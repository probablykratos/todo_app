import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failures.dart';
import 'package:todo/core/usecases/usecases.dart';
import 'package:todo/features/todo/domain/repository/todo_repository.dart';

import '../entities/todo_entity.dart';

class UpdateTodoParamsUseCase implements UseCase<void, UpdateTodoParams> {
  final TodoRepository repository;

  UpdateTodoParamsUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(UpdateTodoParams params) async {
    return await repository.updateTodo(params.todo);
  }
}

class UpdateTodoParams {
  final Todo todo;

  UpdateTodoParams({required this.todo});
}
