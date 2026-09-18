// features/auth/presentation/cubit/auth_state.dart

import 'package:equatable/equatable.dart';

// ملحوظة على Equatable: لو نسينا نعمل extend للـ Equatable هنا،
// BlocBuilder/BlocConsumer ممكن يعمل rebuild زيادة عن اللزوم (لأن كل
// instance جديد بيتحسب "مختلف" حتى لو نفس القيم)، أو العكس ميعملش
// rebuild لما لازم. بنستخدمها هنا عشان نقارن بالـ props مش بالـ reference.

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String userId;
  final String email;

  const AuthSuccess({required this.userId, required this.email});

  @override
  List<Object?> get props => [userId, email];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
