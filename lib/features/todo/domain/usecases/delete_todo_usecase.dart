import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failures.dart';
import 'package:todo/core/usecases/usecases.dart';
import 'package:todo/features/todo/domain/repository/todo_repository.dart';

class DeleteTodoUseCase implements UseCase <void,DeleteTodoParams>{

  final TodoRepository repository;

  DeleteTodoUseCase({required this.repository});
  @override
  Future<Either<Failure, dynamic>> call(DeleteTodoParams params) async {
    return await repository.deleteTodo(params.id);
  }
}

class DeleteTodoParams {
  final String id;

  DeleteTodoParams({required this.id});
}