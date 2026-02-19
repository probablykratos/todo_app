import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/usecases/usecases.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/domain/usecases/create_todo_usecase.dart';
import 'package:todo/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:todo/features/todo/domain/usecases/get_todo_usecase.dart';
import 'package:todo/features/todo/domain/usecases/update_todo_params_usecase.dart';
import 'package:todo/features/todo/presentation/bloc/todo_event.dart';
import 'package:todo/features/todo/presentation/bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodoUseCase getTodoUseCase;
  final CreateTodoUseCase createTodoUseCase;
  final UpdateTodoParamsUseCase updateTodoUsecase;
  final DeleteTodoUseCase deleteTodoUseCase;
  StreamSubscription? _todoSubscription;

  TodoBloc({
    required this.getTodoUseCase,
    required this.createTodoUseCase,
    required this.updateTodoUsecase,
    required this.deleteTodoUseCase,
  }) : super(TodoInitialState()) {
    on<LoadTodo>(_onLoadTodos);
    on<CreateTodoEvent>(_onCreateTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<ToggleTodoEvent>(_onToggleTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  Future<void> _onLoadTodos(LoadTodo event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());

    final result = await getTodoUseCase(NoParams());

    result.fold(
      (failure) => emit(TodoErrorState(message: 'Todo Error State')),
      (todos) => emit(TodoLoadedState(todos: todos)),
    );
  }

  FutureOr<void> _onCreateTodo(
    CreateTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final currentState = state;

    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: event.title,
      description: event.description,
      isCompleted: false,
      createdAt: DateTime.now(),
      priority: event.priority,
    );

    final result = await createTodoUseCase(CreateTodoParams(todo: newTodo));

    result.fold(
      (failure) =>
          emit(TodoErrorState(message: "Todo Error State in Create Todo")),
      (_) {
        if (currentState is TodoLoadedState) {
          emit(TodoLoadedState(todos: [newTodo, ...currentState.todos]));
        }
      },
    );
  }

  Future<void> _onUpdateTodo(
    UpdateTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final currentState = state;

    final result = await updateTodoUsecase(UpdateTodoParams(todo: event.todo));

    result.fold(
      (failure) => emit(TodoErrorState(message: "Error on UpdateTodo")),
      (_) {
        if (currentState is TodoLoadedState) {
          final updateTodos = currentState.todos.map((todo) {
            return todo.id == event.todo.id ? event.todo : todo;
          }).toList();
          emit(TodoLoadedState(todos: updateTodos));
        }
      },
    );
  }

  FutureOr<void> _onDeleteTodo(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final currentState = state;

    final result = await deleteTodoUseCase(DeleteTodoParams(id: event.id));

    result.fold(
      (failure) => emit(TodoErrorState(message: "Error at Delete bloc")),
      (_) {
        emit(TodoOperationSuccess(message: "Todo Deleted"));

        if (currentState is TodoLoadedState) {
          final updatedTodo = currentState.todos
              .where((todo) => todo.id != event.id)
              .toList();
          emit(TodoLoadedState(todos: updatedTodo));
        }
      },
    );
  }

  FutureOr<void> _onToggleTodo(
    ToggleTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final currentState = state;

    final toggledTodo = event.todo.copyWith(
      isCompleted: !event.todo.isCompleted,
    );

    final result = await updateTodoUsecase(UpdateTodoParams(todo: toggledTodo));

    result.fold(
      (failure) => emit(TodoErrorState(message: "Error on toggle todo")),
      (_) {
        if (currentState is TodoLoadedState) {
          final updatedTodo = currentState.todos.map((todo) {
            return todo.id == event.todo.id ? toggledTodo : todo;
          }).toList();
          emit(TodoLoadedState(todos: updatedTodo));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _todoSubscription?.cancel();
    return super.close();
  }
}
