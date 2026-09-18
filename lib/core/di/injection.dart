// core/di/injection.dart
//
// GetIt واحد للتطبيق كله. مقسّم لدالتين مقصودتين:
//
// 1) setupCoreDependencies() — بتتنادى مرة واحدة في main() قبل runApp.
//    بتسجّل حاجات مش محتاجة يوزر مسجل دخول (Dio, DeviceInfoService,
//    ExchangeRateRepository لأنه API عام بدون مصادقة).
//
// 2) setupUserDependencies(userId) — بتتنادى مرة واحدة بس، جوه
//    AuthCubit فور نجاح تسجيل الدخول (مش في main!) لأن
//    TransactionRemoteDataSource محتاج userId عشان يعرف يكتب على
//    users/{userId}/transactions في Firestore، والـ userId ده
//    مش متاح غير بعد ما اليوزر يسجل دخول فعليًا.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import 'package:pay_flow_app/core/network/dio_factory.dart';
import 'package:pay_flow_app/core/services/device_info_service.dart';

import 'package:pay_flow_app/features/exchange_rate/data/datasources/exchange_rate_remote_datasource.dart';
import 'package:pay_flow_app/features/exchange_rate/data/repositories/exchange_rate_repository_impl.dart';
import 'package:pay_flow_app/features/exchange_rate/domain/repositories/exchange_rate_repository.dart';
import 'package:pay_flow_app/features/exchange_rate/domain/usecases/get_exchange_rate.dart';
import 'package:pay_flow_app/features/exchange_rate/presentation/cubit/exchange_rate_cubit.dart';

import 'package:pay_flow_app/features/account/data/datasources/transaction_remote_datasource.dart';
import 'package:pay_flow_app/features/account/data/repositories/transaction_repository_impl.dart';
import 'package:pay_flow_app/features/account/domain/repositories/transaction_repository.dart';
import 'package:pay_flow_app/features/account/domain/usecases/get_account_usecase.dart';
import 'package:pay_flow_app/features/account/presentation/cubit/account_cubit.dart';

final GetIt sl = GetIt.instance;

void setupCoreDependencies() {
  sl.registerLazySingleton(() => DioFactory.getDio());
  sl.registerLazySingleton(() => DeviceInfoService.instance);

  // --- Exchange Rate feature (Data -> Domain -> Presentation كاملة) ---
  sl.registerLazySingleton<ExchangeRateRemoteDataSource>(
    () => ExchangeRateRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ExchangeRateRepository>(
    () => ExchangeRateRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetExchangeRate(sl()));
  sl.registerFactory(() => ExchangeRateCubit(sl()));
}

/// يتنادى مرة واحدة بس بعد نجاح تسجيل الدخول.
void setupUserDependencies(String userId) {
  if (sl.isRegistered<TransactionRemoteDataSource>()) {
    sl.unregister<TransactionRemoteDataSource>();
    sl.unregister<TransactionRepository>();
    sl.unregister<GetAccountUseCase>();
    sl.unregister<AccountCubit>();
  }

  sl.registerLazySingleton<TransactionRemoteDataSource>(
    () => TransactionRemoteDataSource(
      firestore: FirebaseFirestore.instance,
      userId: userId,
    ),
  );
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetAccountUseCase(sl()));
  sl.registerFactory(() => AccountCubit(sl(), sl()));
}

/// يتنادى وقت تسجيل الخروج عشان نمسح دنيا اليوزر القديم من الـ container.
void clearUserDependencies() {
  if (sl.isRegistered<TransactionRemoteDataSource>()) sl.unregister<TransactionRemoteDataSource>();
  if (sl.isRegistered<TransactionRepository>()) sl.unregister<TransactionRepository>();
  if (sl.isRegistered<GetAccountUseCase>()) sl.unregister<GetAccountUseCase>();
  if (sl.isRegistered<AccountCubit>()) sl.unregister<AccountCubit>();
}
