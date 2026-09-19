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

  Future<void> login({required String email, required String password}) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      emit(const AuthError('Please enter your email and password.'));
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
        emit(const AuthError('Failed to retrieve user data.'));
        return;
      }

      di.setupUserDependencies(uid);

      emit(AuthSuccess(userId: uid, email: credential.user?.email ?? email));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_mapFirebaseError(e)));
    } catch (e) {
      emit(AuthError('An unexpected error occurred: $e'));
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
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'invalid-email':
        return 'Invalid email format.';
      case 'network-request-failed':
        return 'No internet connection.';
      default:
        return e.message ?? 'Sign in failed.';
    }
  }
}
