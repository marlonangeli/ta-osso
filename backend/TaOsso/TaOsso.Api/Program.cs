using Npgsql;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var port = builder.Configuration.GetValue<int>("PORT");
builder.WebHost.UseUrls($"http://*:{port};http://localhost:3000");

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();

var summaries = new[]
{
    "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
};

app.MapGet("/weatherforecast", () =>
{
        var forecast = Enumerable.Range(1, 5).Select(index =>
                new WeatherForecast
                (
                    DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
                    Random.Shared.Next(-20, 55),
                    summaries[Random.Shared.Next(summaries.Length)]
                ))
            .ToArray();
        return forecast;
    })
    .WithName("GetWeatherForecast")
    .WithOpenApi();

app.MapGet("/database", async (IConfiguration config) =>
{
    // Get the connection string from the DATABASE_URL environment variable
    var databaseUrl = config["DATABASE_URL"] ?? config["DATABASE_PUBLIC_URL"];
    var connectionString = ConvertDatabaseUrlToConnectionString(databaseUrl!);

    Console.WriteLine($"Connecting string: {connectionString}");

    try
    {
        await using var connection = new NpgsqlConnection(connectionString);
        await connection.OpenAsync();

        await using var command = new NpgsqlCommand("SELECT 1", connection);
        var result = await command.ExecuteScalarAsync();

        return result != null ? "Database connection successful" : "Failed to connect to database";
    }
    catch (Exception ex)
    {
        Console.WriteLine($"Error connecting to the database: {ex.Message}");
        return "Error connecting to the database.";
    }
}).WithName("TestDatabaseConnection").WithOpenApi();

await app.RunAsync();

static string ConvertDatabaseUrlToConnectionString(string databaseUrl)
{
    var uri = new Uri(databaseUrl);

    var host = uri.Host;
    var port = uri.Port;
    var userInfo = uri.UserInfo.Split(':');
    var username = userInfo[0];
    var password = userInfo[1];
    var database = uri.AbsolutePath.Trim('/');

    return $"Host={host};Port={port};Username={username};Password={password};Database={database};SSL Mode=Prefer;Trust Server Certificate=true;";
}

record WeatherForecast(DateOnly Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}