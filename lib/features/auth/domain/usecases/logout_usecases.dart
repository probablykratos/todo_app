import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failures.dart';
import 'package:todo/core/usecases/usecases.dart';
import 'package:todo/features/auth/domain/repository/auth_repository.dart';

class LogoutUseCases implements UseCase<void, NoParams> {
  final AuthRepository repository;

  LogoutUseCases({required this.repository});
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.logout();
  }
}

