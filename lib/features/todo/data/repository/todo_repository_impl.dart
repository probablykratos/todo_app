import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/core/error/failures.dart';
import 'package:todo/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:todo/features/todo/data/model/todo_model.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/domain/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDatasource remoteDatasource;

  TodoRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, void>> createTodo(Todo todo) async {
    try {
      final todoModel = TodoModel.fromEntity(todo);
      await remoteDatasource.createTodo(todoModel);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(String id) async {
    try {
      await remoteDatasource.deleteTodo(id);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodo() async {
    try {
      final remoteTodos = await remoteDatasource.getTodo();
      return Right(remoteTodos);
    } on FirebaseAuthException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Todo>> getTodoById(String id) async {
    try {
      final todo = await remoteDatasource.getTodoById(id);
      return Right(todo);
    } catch (e) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo(Todo todo) async {
    try {
      final todoModel = TodoModel.fromEntity(todo);
      await remoteDatasource.updateTodo(todoModel);
      return Right(null);
    } catch (e) {
      return left(ServerFailure());
    }
  }

  @override
  Stream<Either<Failure, List<Todo>>> watchTodos(){
    try {
      return remoteDatasource.watchTodos().map(
        (todos) => Right<Failure, List<Todo>>(todos),
      );
    } catch (e) {
      return Stream.value(Left(ServerFailure()));
    }
  }
}
