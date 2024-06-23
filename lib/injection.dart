import 'package:get_it/get_it.dart';
import 'package:vtracker/core/api/http_client.dart';
import 'package:vtracker/features/auth/data/datasources/db_helper.dart';
import 'package:vtracker/features/auth/data/datasources/local_datasources.dart';
import 'package:vtracker/features/auth/data/datasources/remote_datasources.dart';
import 'package:vtracker/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:vtracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:vtracker/features/auth/domain/usecases/get_account_list.dart';
import 'package:vtracker/features/auth/domain/usecases/insert_acount_list.dart';
import 'package:vtracker/features/auth/domain/usecases/login_usecase.dart';
import 'package:vtracker/features/auth/presentation/bloc/login_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => LoginBloc(
      loginUsecase: locator(),
      saveUsecase: locator(),
    ),
  );

  locator.registerFactory(
    () => MultiLoginBloc(
      getListUsecase: locator(),
    ),
  );

  //usecase
  locator.registerLazySingleton(() => LoginUsecase(repository: locator()));
  locator.registerLazySingleton(() => SaveAccountList(repository: locator()));
  locator.registerLazySingleton(() => GetAccountList(repository: locator()));

  //repository implentation
  locator.registerLazySingleton<AuthPageRepository>(
    () => AuthRepositoryImpl(
        remoteDataSource: locator(), localDataSource: locator()),
  );

  // data sources
  locator.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthDatasourceImpl(http: locator()));

  // data sources local
  locator.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(databaseHelper: locator()));

// network helper
  locator.registerLazySingleton<HttpClient>(() => HttpClient());

  // network helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
}
