import 'package:dartz/dartz.dart';
import 'package:todo/core/error/exceptions.dart';
import 'package:todo/core/error/failures.dart';
import 'package:todo/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:todo/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:todo/features/auth/domain/entities/user_entity.dart';
import 'package:todo/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryIml implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryIml({
    required this.authRemoteDatasource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    try{
       final user = await authLocalDataSource.getCachedUser();
       return Right(user);
    }catch(e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try{
      final token =await authLocalDataSource.getCachedToken();
      return Right (true);
    }
    catch(e){
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async{
    try{
      final user = await authRemoteDatasource.login(email, password);
      await authLocalDataSource.cacheToken('mock_token${user.id}');
      await authLocalDataSource.cacheUser(user);
      return Right(user);
    }on InvalidCredentialException{
      return Left(InvalidCredentialFailure());
    }on ServerException{
      return Left(ServerFailure());
    }catch(e){
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try{
      await authRemoteDatasource.logout();
      await authLocalDataSource.clearToken();
      return Right(null);

    }catch(e){
      return left(ServerFailure());
    }
  }
}
