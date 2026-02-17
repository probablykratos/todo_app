import 'package:equatable/equatable.dart';
import '../../domain/entities/todo_entity.dart';
abstract class TodoState extends Equatable{

  const TodoState();
  @override
  List<Object?> get props => [];
}


class TodoInitialState extends TodoState{}

class TodoLoadingState extends TodoState{}

class TodoLoadedState extends TodoState{

  final List<Todo> todos;

  const TodoLoadedState({required this.todos});

  @override
  List<Object?> get props => [todos];

}

class TodoErrorState extends TodoState{
  final String message;

  const TodoErrorState({required this.message});

}

class TodoOperationSuccess extends TodoState{
  final String message;

  const TodoOperationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}