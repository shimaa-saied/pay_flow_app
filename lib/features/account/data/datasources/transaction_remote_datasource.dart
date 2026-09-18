// features/account/data/datasources/transaction_remote_datasource.dart
//
// كل instance من الكلاس ده مرتبطة بيوزر واحد بس (userId بييجي في
// الـ constructor)، عشان كده هي بتتسجّل في GetIt بعد تسجيل الدخول
// (في setupUserDependencies) مش قبل كده.

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/transaction_model.dart';

class TransactionRemoteDataSource {
  final FirebaseFirestore firestore;
  final String userId;

  TransactionRemoteDataSource({required this.firestore, required this.userId});

  CollectionReference<Map<String, dynamic>> get _collection =>
      firestore.collection('users').doc(userId).collection('transactions');

  Future<void> addTransaction(TransactionModel transaction) async {
    await _collection.add(transaction.toFirestore());
  }

  Stream<List<TransactionModel>> watchTransactions() {
    return _collection.orderBy('date', descending: true).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => TransactionModel.fromFirestore(doc.data()))
              .toList(),
        );
  }
}
