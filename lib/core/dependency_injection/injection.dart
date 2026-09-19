import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../api/dio_factory.dart';
import '../router/app_router.dart';
import '../services/device_info_service.dart';
import '../services/user_session.dart';
import '../../features/home/data/datasource/remote/transaction_remote_datasource_impl.dart';
import '../../features/home/data/repositories/transaction_repository_impl.dart';
import '../../features/home/domain/repositories/transaction_repository.dart';
import '../../features/home/domain/usecases/add_transaction_usecase.dart';
import '../../features/home/domain/usecases/get_transactions_usecase.dart';
import '../../features/home/presentation/cubit/account_cubit/account_cubit.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/home/data/datasource/remote/exchange_rate_remote_datasource_impl.dart';
import '../../features/home/data/repositories/exchange_rate_repository_impl.dart';
import '../../features/home/domain/repositories/exchange_rate_repository.dart';
import '../../features/home/domain/usecases/get_exchange_rate_usecase.dart';
import '../../features/home/presentation/cubit/exchange_rate_cubit/exchange_rate_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // ── Infrastructure ───────────────────────────────────────────────────────
  getIt.registerLazySingleton(() => DioFactory.create());
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => DeviceInfoService.instance);
  getIt.registerLazySingleton(() => UserSession());

  // ── Router ───────────────────────────────────────────────────────────────
  getIt.registerLazySingleton(() => AppRouter(getIt<UserSession>()));

  // ── Transaction ──────────────────────────────────────────────────────────
  getIt.registerLazySingleton(
    () => TransactionRemoteDataSourceImpl(
      getIt<FirebaseFirestore>(),
      getIt<UserSession>(),
    ),
  );
  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(getIt<TransactionRemoteDataSourceImpl>()),
  );
  getIt.registerFactory(
    () => GetTransactionsUseCase(getIt<TransactionRepository>()),
  );
  getIt.registerFactory(
    () => AddTransactionUseCase(getIt<TransactionRepository>()),
  );
  getIt.registerFactory(
    () => AccountCubit(
      getIt<GetTransactionsUseCase>(),
      getIt<AddTransactionUseCase>(),
    ),
  );

  // ── Exchange Rate ─────────────────────────────────────────────────────────
  getIt.registerLazySingleton(
    () => ExchangeRateRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<ExchangeRateRepository>(
    () => ExchangeRateRepositoryImpl(getIt<ExchangeRateRemoteDataSourceImpl>()),
  );
  getIt.registerFactory(
    () => GetExchangeRateUseCase(getIt<ExchangeRateRepository>()),
  );
  getIt.registerFactory(
    () => ExchangeRateCubit(getIt<GetExchangeRateUseCase>()),
  );

  // ── Auth ─────────────────────────────────────────────────────────────────
  getIt.registerFactory(
    () => AuthCubit(getIt<FirebaseAuth>(), getIt<UserSession>()),
  );
}
