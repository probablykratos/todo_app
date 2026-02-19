import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:todo/features/auth/data/repository/auth_repository_iml.dart';
import 'package:todo/features/auth/domain/repository/auth_repository.dart';
import 'package:todo/features/auth/domain/usecases/check_auth_usercase.dart';
import 'package:todo/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:todo/features/auth/domain/usecases/login_usecases.dart';
import 'package:todo/features/auth/domain/usecases/register_usecase.dart';
import 'package:todo/features/auth/presentations/bloc/auth_bloc.dart';
import 'package:todo/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:todo/features/todo/domain/usecases/create_todo_usecase.dart';
import 'package:todo/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:todo/features/todo/domain/usecases/get_todo_usecase.dart';
import 'package:todo/features/todo/domain/usecases/update_todo_params_usecase.dart';
import 'features/auth/domain/usecases/logout_usecases.dart';
import 'features/todo/data/repository/todo_repository_impl.dart';
import 'features/todo/domain/repository/todo_repository.dart';
import 'features/todo/presentation/bloc/todo_bloc.dart';

final sl = GetIt.instance;

Future init() async {
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  sl.registerFactory(
    () => AuthBloc(
      registerUseCase: sl(),
      loginUseCases: sl(),
      logoutUseCases: sl(),
      getCurrentUserUseCase: sl(),
      checkAuthUserCase: sl(),
    ),
  );
  sl.registerFactory(
    () => TodoBloc(
      getTodoUseCase: sl(),
      createTodoUseCase: sl(),
      updateTodoUsecase: sl(),
      deleteTodoUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => RegisterUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => LoginUseCases(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCases(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => CheckAuthUserCase(repository: sl()));

  sl.registerLazySingleton(() => GetTodoUseCase(sl()));
  sl.registerLazySingleton(() => CreateTodoUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateTodoParamsUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteTodoUseCase(repository: sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryIml(authRemoteDatasource: sl()),
  );

  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(remoteDatasource: sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl(), firestore: sl()),
  );
  sl.registerLazySingleton<TodoRemoteDatasource>(
    () => TodoRemoteDataSourceImpl(firestore: sl(), auth: sl()),
  );

  final sharedPreference = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreference);
}
