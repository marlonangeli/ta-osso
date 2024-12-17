class CardModel {
  final String id;
  final String name;
  final String accountId;
  final double limit;
  final String iconPath;
  final String bankName;
  final int closingDay;
  final int dueDay;
  final DateTime createdAt;
  final DateTime updatedAt;

  CardModel({
    required this.id,
    required this.name,
    required this.accountId,
    required this.limit,
    required this.iconPath,
    required this.bankName,
    required this.closingDay,
    required this.dueDay,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'accountId': accountId,
    'limit': limit,
    'iconPath': iconPath,
    'bankName': bankName,
    'closingDay': closingDay,
    'dueDay': dueDay,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
    id: json['id'],
    name: json['name'],
    accountId: json['accountId'],
    limit: json['limit'].toDouble(),
    iconPath: json['iconPath'],
    bankName: json['bankName'],
    closingDay: json['closingDay'],
    dueDay: json['dueDay'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
  );
}