import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _AuthInitial;
  const factory AuthState.loading() = _AuthLoading;
  const factory AuthState.authenticated({
    required String userId,
    required String email,
  }) = Authenticated;
  const factory AuthState.unauthenticated({String? errorMessage}) = Unauthenticated;
}
