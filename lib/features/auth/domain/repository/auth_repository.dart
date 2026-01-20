import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failures.dart';
import 'package:todo/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure,UserEntity>> login({
    required String email,
    required String password
});
  Future<Either<Failure,void>>  logout();

  Future<Either<Failure,UserEntity>>  getUser();

  Future<Either<Failure,bool>>  isAuthenticated();
}