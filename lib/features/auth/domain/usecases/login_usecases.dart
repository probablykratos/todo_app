import 'package:dartz/dartz.dart';
import 'package:todo/core/usecases/usecases.dart';
import 'package:todo/features/auth/domain/entities/user_entity.dart';

import '../../../../core/error/failures.dart';
import 'package:todo/features/auth/domain/repository/auth_repository.dart';

class LoginUseCases implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCases({required this.repository});
  @override
  Future<Either<Failure, UserEntity>> call(params) async {
    return await repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});

}

