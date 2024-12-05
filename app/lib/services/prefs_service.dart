import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {

  //Metodo para salva String
  Future<void> salvarString(String chave, String valor) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(chave, valor);
  }

  //Metodo para salva int
  Future<void> salvarInt(String chave, int valor) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(chave, valor);
  }

  //Metodo para salva double
  Future<void> salvarDouble(String chave, double valor) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(chave, valor);
  }

  //Metodo para salva bool
  Future<void> salvarBool(String chave, bool valor) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(chave, valor);
  }

  //Metodo para salva List<String>
  Future<void> salvarListString(String chave, List<String> valor) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(chave, valor);
  }

  //Metodo para carregar dados com valores padrão

  Future<String> carregarString(String chave, {String valorPadrao = ''}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(chave) ?? valorPadrao;
  }

    Future<int> carregarInt(String chave, {int valorPadrao = 0}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(chave) ?? valorPadrao;
  }

    Future<bool> carregarBool(String chave, {bool valorPadrao = false}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(chave) ?? valorPadrao;
  }

    Future<double> carregarDouble(String chave, {double valorPadrao = 0.0}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(chave) ?? valorPadrao;
  }

    Future<List<String>> carregarListString(String chave, {List<String> valorPadrao = const[]}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(chave) ?? valorPadrao;
  }

  //Metodo para remover uma chave
  Future<void> removeDado(String chave) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(chave);
  }

  //Metodo para limpar todos os dados
  Future<void> limparTudo() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}