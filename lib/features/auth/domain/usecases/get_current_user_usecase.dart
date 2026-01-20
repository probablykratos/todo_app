import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failures.dart';
import 'package:todo/core/usecases/usecases.dart';
import 'package:todo/features/auth/domain/entities/user_entity.dart';
import 'package:todo/features/auth/domain/repository/auth_repository.dart';


class GetCurrentUserUseCase implements UseCase<UserEntity?,NoParams>{

  final AuthRepository repository;

  GetCurrentUserUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) async {
    return await repository.getUser();
  }
  
}