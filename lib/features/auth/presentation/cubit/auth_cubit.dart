import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/user_session.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth;
  final UserSession _userSession;

  AuthCubit(this._firebaseAuth, this._userSession)
      : super(_resolveInitialState(_userSession));

  static AuthState _resolveInitialState(UserSession session) {
    if (session.isAuthenticated) {
      return AuthState.authenticated(
        userId: session.userId!,
        email: session.email ?? '',
      );
    }
    return const AuthState.initial();
  }

  Future<void> login({required String email, required String password}) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      emit(const AuthState.unauthenticated(
        errorMessage: 'Please enter your email and password.',
      ));
      return;
    }

    emit(const AuthState.loading());

    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final uid = credential.user?.uid;
      final userEmail = credential.user?.email ?? email;

      if (uid == null) {
        emit(const AuthState.unauthenticated(
          errorMessage: 'Failed to retrieve user data.',
        ));
        return;
      }

      _userSession.login(uid, userEmail);
      emit(AuthState.authenticated(userId: uid, email: userEmail));
    } on FirebaseAuthException catch (e) {
      emit(AuthState.unauthenticated(errorMessage: _mapFirebaseError(e)));
    } catch (e) {
      emit(const AuthState.unauthenticated(
        errorMessage: 'An unexpected error occurred.',
      ));
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    _userSession.logout();
    emit(const AuthState.initial());
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
