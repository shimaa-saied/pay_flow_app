import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/services/user_session.dart';
import '../../models/transaction_model.dart';
import 'transaction_remote_datasource.dart';

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final FirebaseFirestore _firestore;
  final UserSession _session;

  TransactionRemoteDataSourceImpl(this._firestore, this._session);

  CollectionReference<Map<String, dynamic>> get _collection => _firestore
      .collection('users')
      .doc(_session.userId)
      .collection('transactions');

  @override
  Future<void> addTransaction(TransactionModel model) async {
    await _collection.add(model.toFirestore());
  }

  @override
  Stream<List<TransactionModel>> watchTransactions() {
    return _collection.orderBy('date', descending: true).snapshots().map(
          (snap) => snap.docs
              .map((doc) => TransactionModel.fromFirestore(doc.data()))
              .toList(),
        );
  }
}