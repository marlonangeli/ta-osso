class Usuario {
  String id;
  String nome;
  String email;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
  });

  // Converter um documento Firestore para o modelo Usuario
  factory Usuario.fromMap(Map<String, dynamic> map, String id) {
    return Usuario(
      id: id,
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
    );
  }

  // Converter o modelo Usuario para um Map para salvar no Firestore
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
    };
  }
}
