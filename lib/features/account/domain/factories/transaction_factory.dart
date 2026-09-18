// features/account/domain/factories/transaction_factory.dart
//
// Factory Pattern:
// بدل ما كل حاجة في الكود تعمل Transaction(...) بنفسها وتعرف تفاصيل
// الـ constructor، الـ Factory بتمركز منطق الإنشاء في مكان واحد.
// النتيجة: لو غيّرنا هيكل Transaction، بنغيّر مكان واحد بس.

import '../entities/transaction.dart';

class TransactionFactory {
  TransactionFactory._();

  static Transaction create(TransactionType type, double amount) {
    switch (type) {
      case TransactionType.deposit:
        return Transaction(
          type: TransactionType.deposit,
          amount: amount,
          date: DateTime.now(),
        );
      case TransactionType.withdraw:
        return Transaction(
          type: TransactionType.withdraw,
          amount: amount,
          date: DateTime.now(),
        );
    }
  }
}
