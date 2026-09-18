// features/auth/presentation/cubit/auth_cubit.dart
//
// Auth بسيط: الـ Cubit بينادي FirebaseAuth مباشرة من غير Repository/UseCase.
// مش كل feature محتاج كل الطبقات.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pay_flow_app/core/di/injection.dart' as di;
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthCubit({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(AuthInitial());

  // ============================================================
  // 🎯 LIVE CODE — Write this part during the session
  // ============================================================
  Future<void> login({required String email, required String password}) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      emit(const AuthError('من فضلك اكتب الإيميل والباسورد.'));
      return;
    }

    emit(AuthLoading());

    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final uid = credential.user?.uid;
      if (uid == null) {
        emit(const AuthError('تعذر الحصول على بيانات المستخدم.'));
        return;
      }

      di.setupUserDependencies(uid);

      emit(AuthSuccess(userId: uid, email: credential.user?.email ?? email));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_mapFirebaseError(e)));
    } catch (e) {
      emit(AuthError('حصل خطأ غير متوقع: $e'));
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    di.clearUserDependencies();
    emit(AuthInitial());
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'مفيش حساب بالإيميل ده.';
      case 'wrong-password':
        return 'الباسورد غلط.';
      case 'invalid-email':
        return 'صيغة الإيميل غير صحيحة.';
      case 'network-request-failed':
        return 'مفيش اتصال بالإنترنت.';
      default:
        return e.message ?? 'فشل تسجيل الدخول.';
    }
  }
}
