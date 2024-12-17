import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ta_osso/models/AccountModel.dart';

class AccountService {
  final CollectionReference _accountsCollection = 
      FirebaseFirestore.instance.collection('accounts');

  // Criar uma nova conta
  Future<String> createAccount(AccountModel account) async {
    try {
      final docRef = await _accountsCollection.add({
        'title': account.title,
        'initialBalance': account.initialBalance,
        'iconPath': account.iconPath,
        'bankName': account.bankName,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      await docRef.update({'id': docRef.id});
      
      return docRef.id;
    } catch (e) {
      throw Exception('Erro ao criar conta: $e');
    }
  }

  // Buscar todas as contas
  Stream<List<AccountModel>> getAccounts() {
    return _accountsCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return AccountModel.fromJson(data);
      }).toList();
    });
  }

  // Atualizar uma conta
  Future<void> updateAccount(AccountModel account) async {
    try {
      await _accountsCollection.doc(account.id).update({
        'title': account.title,
        'initialBalance': account.initialBalance,
        'iconPath': account.iconPath,
        'bankName': account.bankName,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Erro ao atualizar conta: $e');
    }
  }

  // Deletar uma conta
  Future<void> deleteAccount(String accountId) async {
    try {
      await _accountsCollection.doc(accountId).delete();
    } catch (e) {
      throw Exception('Erro ao deletar conta: $e');
    }
  }
}