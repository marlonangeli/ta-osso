import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('usuarios');

  Future<void> saveUser(User user, String nome) async {
    try {
      await _userCollection.doc(user.uid).set({
        'nome': nome,
        'email': user.email,
        'dataCriacao': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Erro ao salvar usuário no Firestore: $e');
    }
  }

  Future<void> verifyAndSaveUser(User user, String nome) async {
    DocumentSnapshot doc = await _userCollection.doc(user.uid).get();
    if (!doc.exists) {
      await saveUser(user, nome);
    }
  }
}
