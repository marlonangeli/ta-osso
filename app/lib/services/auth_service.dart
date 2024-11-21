import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'Nenhum usuário encontrado para esse email.';
      } else if (e.code == 'wrong-password') {
        throw 'Senha incorreta fornecida.';
      } else {
        throw 'Erro ao fazer login: ${e.message}';
      }
    }
  }

  Future<User?> createUserWithEmailPassword(
      String email, String password, String? displayName) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (displayName != null) {
        await userCredential.user?.updateDisplayName(displayName);
      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw 'Já existe uma conta com esse email.';
      } else if (e.code == 'weak-password') {
        throw 'Senha fraca.';
      } else {
        throw 'Erro ao criar usuário: ${e.message}';
      }
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
