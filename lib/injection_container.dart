import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:todo/features/auth/data/repository/auth_repository_iml.dart';
import 'package:todo/features/auth/domain/repository/auth_repository.dart';
import 'package:todo/features/auth/domain/usecases/check_auth_usercase.dart';
import 'package:todo/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:todo/features/auth/domain/usecases/login_usecases.dart';
import 'package:todo/features/auth/presentations/bloc/auth_bloc.dart';

import 'features/auth/domain/usecases/logout_usecases.dart';

final sl = GetIt.instance;

Future init() async {
  sl.registerFactory(
    () => AuthBloc(
      registerUseCase: sl(),
      loginUseCases: sl(),
      logoutUseCases: sl(),
      getCurrentUserUseCase: sl(),
      checkAuthUserCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => LoginUseCases(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCases(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => CheckAuthUserCase(repository: sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryIml(
      authRemoteDatasource: sl(),
    ),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl()),
  );


  final sharedPreference= await SharedPreferences.getInstance();
  sl.registerLazySingleton(()=>sharedPreference); 
}
