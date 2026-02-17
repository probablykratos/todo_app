import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failures.dart';
import 'package:todo/core/usecases/usecases.dart';
import 'package:todo/features/todo/domain/repository/todo_repository.dart';
import '../entities/todo_entity.dart';

class WatchTodoUseCase implements StreamUseCase<List<Todo>,NoParams> {

  final TodoRepository repository;

  WatchTodoUseCase({required this.repository});
  @override
  Stream<Either<Failure, List<Todo>>> call(NoParams params)  {
    return  repository.watchTodos();
  }
}

