import 'package:dartz/dartz.dart';
import 'package:todo/core/error/exceptions.dart';
import 'package:todo/core/error/failures.dart';
import 'package:todo/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:todo/features/auth/domain/entities/user_entity.dart';
import 'package:todo/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryIml implements AuthRepository {
  final AuthRemoteDataSource authRemoteDatasource;

  AuthRepositoryIml({required this.authRemoteDatasource});

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authRemoteDatasource.signInWithEmail(email, password);
      return Right(user.toEntity());
    } on InvalidCredentialException {
      return Left(InvalidCredentialFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await authRemoteDatasource.signOut();
      return Right(null);
    } catch (e) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    try {
      final user = await authRemoteDatasource.getCurrentUser();
      if (user != null) {
        return Right(user.toEntity());
      }
      return Left(CacheFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final user = await authRemoteDatasource.getCurrentUser();
      return Right(user != null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try{
      final user = await authRemoteDatasource.signUpWithEmail(email, password);
      return Right(user.toEntity());
    }catch(e){
      return Left(ServerFailure());
    }
  }
}
