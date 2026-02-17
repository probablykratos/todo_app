import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failures.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';


abstract class TodoRepository {
  Future<Either<Failure,List<Todo>>> getTodo();
  Future<Either<Failure,Todo>> getTodoById(String id);
  Future<Either<Failure,void>> createTodo(Todo todo);
  Future<Either<Failure,void>> updateTodo(Todo todo);
  Future<Either<Failure,void>> deleteTodo(String id);

  Stream<Either<Failure, List<Todo>>> watchTodos();
}