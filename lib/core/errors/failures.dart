// core/errors/failures.dart
//
// Failures بسيطة مشتركة بين كل الـ features.
// أي Repository بيمسك الـ Exception الخام (DioException / FirebaseException)
// وبيحوّله لـ Failure واضح، عشان الـ Cubit ميعرفش تفاصيل الـ data layer.

abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
