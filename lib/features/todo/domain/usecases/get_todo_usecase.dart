import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failures.dart';
import 'package:todo/core/usecases/usecases.dart';
import 'package:todo/features/todo/domain/repository/todo_repository.dart';
import '../entities/todo_entity.dart';

class GetTodoUseCase implements UseCase<List<Todo>,NoParams> {

  final TodoRepository repository;

  GetTodoUseCase(this.repository);
  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async {
    return await repository.getTodo();
  }
  
}