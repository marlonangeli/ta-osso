class AccountModel {
  final String id;
  final String title;
  final double initialBalance;
  final String iconPath;
  final String bankName;
  final DateTime createdAt;
  final DateTime updatedAt;

  AccountModel({
    required this.id,
    required this.title,
    required this.initialBalance,
    required this.iconPath,
    required this.bankName,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'initialBalance': initialBalance,
    'iconPath': iconPath,
    'bankName': bankName,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
    id: json['id'],
    title: json['title'],
    initialBalance: json['initialBalance'].toDouble(),
    iconPath: json['iconPath'],
    bankName: json['bankName'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
  );
}