import 'package:dartz/dartz.dart';

import 'package:todo/core/error/failures.dart';
import 'package:todo/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/usecases/usecases.dart';

class CheckAuthUserCase implements UseCase<bool, NoParams> {
  final AuthRepository repository;

  CheckAuthUserCase({required this.repository});
  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.isAuthenticated();
  }
}
