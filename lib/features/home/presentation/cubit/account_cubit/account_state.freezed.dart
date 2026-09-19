// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(double balance, String currency,
            List<Transaction> transactions, String? errorMessage)
        loaded,
    required TResult Function(String message) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(double balance, String currency,
            List<Transaction> transactions, String? errorMessage)?
        loaded,
    TResult? Function(String message)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(double balance, String currency,
            List<Transaction> transactions, String? errorMessage)?
        loaded,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AccountInitial value) initial,
    required TResult Function(_AccountLoading value) loading,
    required TResult Function(AccountLoaded value) loaded,
    required TResult Function(_AccountFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AccountInitial value)? initial,
    TResult? Function(_AccountLoading value)? loading,
    TResult? Function(AccountLoaded value)? loaded,
    TResult? Function(_AccountFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AccountInitial value)? initial,
    TResult Function(_AccountLoading value)? loading,
    TResult Function(AccountLoaded value)? loaded,
    TResult Function(_AccountFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountStateCopyWith<$Res> {
  factory $AccountStateCopyWith(
          AccountState value, $Res Function(AccountState) then) =
      _$AccountStateCopyWithImpl<$Res, AccountState>;
}

/// @nodoc
class _$AccountStateCopyWithImpl<$Res, $Val extends AccountState>
    implements $AccountStateCopyWith<$Res> {
  _$AccountStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

// ── initial ──────────────────────────────────────────────────────────────────

/// @nodoc
abstract class _$$AccountInitialImplCopyWith<$Res> {
  factory _$$AccountInitialImplCopyWith(_$AccountInitialImpl value,
          $Res Function(_$AccountInitialImpl) then) =
      __$$AccountInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AccountInitialImplCopyWithImpl<$Res>
    extends _$AccountStateCopyWithImpl<$Res, _$AccountInitialImpl>
    implements _$$AccountInitialImplCopyWith<$Res> {
  __$$AccountInitialImplCopyWithImpl(
      _$AccountInitialImpl _value, $Res Function(_$AccountInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc
class _$AccountInitialImpl implements _AccountInitial {
  const _$AccountInitialImpl();

  @override
  String toString() => 'AccountState.initial()';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other.runtimeType == runtimeType && other is _$AccountInitialImpl);

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(double balance, String currency,
            List<Transaction> transactions, String? errorMessage)
        loaded,
    required TResult Function(String message) failure,
  }) =>
      initial();

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(double balance, String currency,
            List<Transaction> transactions, String? errorMessage)?
        loaded,
    TResult? Function(String message)? failure,
  }) =>
      initial?.call();

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(double balance, String currency,
            List<Transaction> transactions, String? errorMessage)?
        loaded,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) return initial();
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AccountInitial value) initial,
    required TResult Function(_AccountLoading value) loading,
    required TResult Function(AccountLoaded value) loaded,
    required TResult Function(_AccountFailure value) failure,
  }) =>
      initial(this);

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AccountInitial value)? initial,
    TResult? Function(_AccountLoading value)? loading,
    TResult? Function(AccountLoaded value)? loaded,
    TResult? Function(_AccountFailure value)? failure,
  }) =>
      initial?.call(this);

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AccountInitial value)? initial,
    TResult Function(_AccountLoading value)? loading,
    TResult Function(AccountLoaded value)? loaded,
    TResult Function(_AccountFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) return initial(this);
    return orElse();
  }
}

abstract class _AccountInitial implements AccountState {
  const factory _AccountInitial() = _$AccountInitialImpl;
}

// ── loading ───────────────────────────────────────────────────────────────────

/// @nodoc
abstract class _$$AccountLoadingImplCopyWith<$Res> {
  factory _$$AccountLoadingImplCopyWith(_$AccountLoadingImpl value,
          $Res Function(_$AccountLoadingImpl) then) =
      __$$AccountLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AccountLoadingImplCopyWithImpl<$Res>
    extends _$AccountStateCopyWithImpl<$Res, _$AccountLoadingImpl>
    implements _$$AccountLoadingImplCopyWith<$Res> {
  __$$AccountLoadingImplCopyWithImpl(
      _$AccountLoadingImpl _value, $Res Function(_$AccountLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc
class _$AccountLoadingImpl implements _AccountLoading {
  const _$AccountLoadingImpl();

  @override
  String toString() => 'AccountState.loading()';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other.runtimeType == runtimeType && other is _$AccountLoadingImpl);

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(double balance, String currency,
            List<Transaction> transactions, String? errorMessage)
        loaded,
    required TResult Function(String message) failure,
  }) =>
      loading();

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(double balance, String currency,
            List<Transaction> transactions, String? errorMessage)?
        loaded,
    TResult? Function(String message)? failure,
  }) =>
      loading?.call();

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(double balance, String currency,
            List<Transaction> transactions, String? errorMessage)?
        loaded,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) return loading();
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AccountInitial value) initial,
    required TResult Function(_AccountLoading value) loading,
    required TResult Function(AccountLoaded value) loaded,
    required TResult Function(_AccountFailure value) failure,
  }) =>
      loading(this);

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AccountInitial value)? initial,
    TResult? Function(_AccountLoading value)? loading,
    TResult? Function(AccountLoaded value)? loaded,
    TResult? Function(_AccountFailure value)? failure,
  }) =>
      loading?.call(this);

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AccountInitial value)? initial,
    TResult Function(_AccountLoading value)? loading,
    TResult Function(AccountLoaded value)? loaded,
    TResult Function(_AccountFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) return loading(this);
    return orElse();
  }
}

abstract class _AccountLoading implements AccountState {
  const factory _AccountLoading() = _$AccountLoadingImpl;
}

// ── loaded ────────────────────────────────────────────────────────────────────

/// @nodoc
abstract class _$$AccountLoadedImplCopyWith<$Res> {
  factory _$$AccountLoadedImplCopyWith(
          AccountLoaded value, $Res Function(AccountLoaded) then) =
      __$$AccountLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {double balance,
      String currency,
      List<Transaction> transactions,
      String? errorMessage});
}

/// @nodoc
class __$$AccountLoadedImplCopyWithImpl<$Res>
    extends _$AccountStateCopyWithImpl<$Res, AccountLoaded>
    implements _$$AccountLoadedImplCopyWith<$Res> {
  __$$AccountLoadedImplCopyWithImpl(
      AccountLoaded _value, $Res Function(AccountLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? currency = null,
    Object? transactions = null,
    Object? errorMessage = freezed,
  }) {
    return _then(AccountLoaded(
      null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      null == transactions
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<Transaction>,
      freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
class AccountLoaded implements AccountState {
  const AccountLoaded(
      this.balance, this.currency, this.transactions, this.errorMessage);

  final double balance;
  final String currency;
  final List<Transaction> transactions;
  final String? errorMessage;

  @override
  String toString() {
    return 'AccountState.loaded(balance: $balance, currency: $currency, transactions: $transactions, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other.runtimeType == runtimeType &&
          other is AccountLoaded &&
          (identical(other.balance, balance) || other.balance == balance) &&
          (identical(other.currency, currency) ||
              other.currency == currency) &&
          (identical(other.transactions, transactions) ||
              other.transactions == transactions) &&
          (identical(other.errorMessage, errorMessage) ||
              other.errorMessage == errorMessage));

  @override
  int get hashCode =>
      Object.hash(runtimeType, balance, currency, transactions, errorMessage);

  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$$AccountLoadedImplCopyWith<AccountLoaded> get copyWith =>
      __$$AccountLoadedImplCopyWithImpl<AccountLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(double balance, String currency,
            List<Transaction> transactions, String? errorMessage)
        loaded,
    required TResult Function(String message) failure,
  }) =>
      loaded(balance, currency, transactions, errorMessage);

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(double balance, String currency,
            List<Transaction> transactions, String? errorMessage)?
        loaded,
    TResult? Function(String message)? failure,
  }) =>
      loaded?.call(balance, currency, transactions, errorMessage);

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(double balance, String currency,
            List<Transaction> transactions, String? errorMessage)?
        loaded,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) return loaded(balance, currency, transactions, errorMessage);
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AccountInitial value) initial,
    required TResult Function(_AccountLoading value) loading,
    required TResult Function(AccountLoaded value) loaded,
    required TResult Function(_AccountFailure value) failure,
  }) =>
      loaded(this);

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AccountInitial value)? initial,
    TResult? Function(_AccountLoading value)? loading,
    TResult? Function(AccountLoaded value)? loaded,
    TResult? Function(_AccountFailure value)? failure,
  }) =>
      loaded?.call(this);

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AccountInitial value)? initial,
    TResult Function(_AccountLoading value)? loading,
    TResult Function(AccountLoaded value)? loaded,
    TResult Function(_AccountFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) return loaded(this);
    return orElse();
  }
}

// ── failure ───────────────────────────────────────────────────────────────────

/// @nodoc
abstract class _$$AccountFailureImplCopyWith<$Res> {
  factory _$$AccountFailureImplCopyWith(_$AccountFailureImpl value,
          $Res Function(_$AccountFailureImpl) then) =
      __$$AccountFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AccountFailureImplCopyWithImpl<$Res>
    extends _$AccountStateCopyWithImpl<$Res, _$AccountFailureImpl>
    implements _$$AccountFailureImplCopyWith<$Res> {
  __$$AccountFailureImplCopyWithImpl(_$AccountFailureImpl _value,
      $Res Function(_$AccountFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(_$AccountFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
class _$AccountFailureImpl implements _AccountFailure {
  const _$AccountFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() => 'AccountState.failure(message: $message)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other.runtimeType == runtimeType &&
          other is _$AccountFailureImpl &&
          (identical(other.message, message) || other.message == message));

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$$AccountFailureImplCopyWith<_$AccountFailureImpl> get copyWith =>
      __$$AccountFailureImplCopyWithImpl<_$AccountFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(double balance, String currency,
            List<Transaction> transactions, String? errorMessage)
        loaded,
    required TResult Function(String message) failure,
  }) =>
      failure(message);

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(double balance, String currency,
            List<Transaction> transactions, String? errorMessage)?
        loaded,
    TResult? Function(String message)? failure,
  }) =>
      failure?.call(message);

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(double balance, String currency,
            List<Transaction> transactions, String? errorMessage)?
        loaded,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) return failure(message);
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AccountInitial value) initial,
    required TResult Function(_AccountLoading value) loading,
    required TResult Function(AccountLoaded value) loaded,
    required TResult Function(_AccountFailure value) failure,
  }) =>
      failure(this);

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AccountInitial value)? initial,
    TResult? Function(_AccountLoading value)? loading,
    TResult? Function(AccountLoaded value)? loaded,
    TResult? Function(_AccountFailure value)? failure,
  }) =>
      failure?.call(this);

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AccountInitial value)? initial,
    TResult Function(_AccountLoading value)? loading,
    TResult Function(AccountLoaded value)? loaded,
    TResult Function(_AccountFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) return failure(this);
    return orElse();
  }
}

abstract class _AccountFailure implements AccountState {
  const factory _AccountFailure(final String message) = _$AccountFailureImpl;

  String get message;

  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountFailureImplCopyWith<_$AccountFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}