import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failures.dart';
import 'package:todo/core/usecases/usecases.dart';
import 'package:todo/features/todo/domain/repository/todo_repository.dart';

import '../entities/todo_entity.dart';

class CreateTodoUseCase implements UseCase<void,CreateTodoParams>{

  final TodoRepository repository;

  CreateTodoUseCase({required this.repository});
  @override
  Future<Either<Failure, void>> call(CreateTodoParams params) async {
    return await repository.createTodo(params.todo);
  }
}
class CreateTodoParams{
  final Todo todo;

  CreateTodoParams({required this.todo});


}