// lib/services/card_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ta_osso/models/CardModel.dart';

class CardService {
  final CollectionReference _cardsCollection = 
      FirebaseFirestore.instance.collection('cards');

  Future<String> createCard(CardModel card) async {
    try {
      final docRef = await _cardsCollection.add({
        'name': card.name,
        'accountId': card.accountId,
        'limit': card.limit,
        'iconPath': card.iconPath,
        'bankName': card.bankName,
        'closingDay': card.closingDay,
        'dueDay': card.dueDay,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      await docRef.update({'id': docRef.id});
      
      return docRef.id;
    } catch (e) {
      throw Exception('Erro ao criar cartão: $e');
    }
  }

  Stream<List<CardModel>> getCards() {
    return _cardsCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return CardModel.fromJson(data);
      }).toList();
    });
  }
}