import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failures.dart';
import 'package:todo/core/usecases/usecases.dart';
import 'package:todo/features/auth/domain/entities/user_entity.dart';
import 'package:todo/features/auth/domain/usecases/login_usecases.dart';

import '../repository/auth_repository.dart';

class RegisterUseCase implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});
  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) async {
    return await authRepository.signUp(
      email: params.email,
      password: params.password,
      username: params.username,
    );
  }
}

class RegisterParams {
  final String email;
  final String password;
  final String username;

  RegisterParams({
    required this.email,
    required this.password,
    required this.username,
  });
}
