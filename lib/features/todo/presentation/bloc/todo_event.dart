import 'package:equatable/equatable.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
  @override
  List<Object?> get props => [];
}

class LoadTodo extends TodoEvent {}

class WatchTodo extends TodoEvent {}

class CreateTodoEvent extends TodoEvent {
  final String title;
  final String description;
  final Priority priority;

  const CreateTodoEvent({
    required this.title,
    required this.description,
    required this.priority,
  });

  @override
  List<Object?> get props => [title, description];
}

class UpdateTodoEvent extends TodoEvent {
  final Todo todo;
  const UpdateTodoEvent({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class ToggleTodoEvent extends TodoEvent {
  final Todo todo;

  const ToggleTodoEvent({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class DeleteTodoEvent extends TodoEvent {
  final String id;

  const DeleteTodoEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
