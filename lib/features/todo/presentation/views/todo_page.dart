import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/features/auth/presentations/bloc/auth_event.dart';
import 'package:todo/features/todo/presentation/bloc/todo_event.dart';
import 'package:todo/features/todo/presentation/bloc/todo_state.dart';
import 'package:todo/features/todo/presentation/views/add_todo.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentations/bloc/auth_bloc.dart';
import '../bloc/todo_bloc.dart';

class TodoPageView extends StatefulWidget {
  const TodoPageView({super.key});

  @override
  State<TodoPageView> createState() => _TodoPageViewState();
}

class _TodoPageViewState extends State<TodoPageView> {
  late Future<String> _usernameFuture;

  Future<String> _getUsername() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    return doc.data()?['username'] ?? 'User';
  }

  @override
  void initState() {
    super.initState();
    _usernameFuture = _getUsername();
  }

  Color _priorityColor(Priority priority, BuildContext context) {
    switch (priority) {
      case Priority.high:
        return Theme.of(context).colorScheme.error;
      case Priority.medium:
        return Theme.of(context).colorScheme.tertiary;
      case Priority.low:
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  String _priorityLabel(Priority priority) {
    switch (priority) {
      case Priority.high:
        return 'High';
      case Priority.medium:
        return 'Medium';
      case Priority.low:
      default:
        return 'Low';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (_) => sl<TodoBloc>()..add(LoadTodo()),
      child: Scaffold(
        appBar: AppBar(
          title: FutureBuilder<String>(
            future: _usernameFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text("User's Todo");
              }
              final username = snapshot.data;
              return Text("$username's Todo");
            },
          ),
        ),
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                const DrawerHeader(
                  child: Center(
                    child: Text("Menu", style: TextStyle(fontSize: 22)),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  title: Text(
                    "Log out",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    context.read<AuthBloc>().add(AuthLogoutEvent());
                  },
                ),
              ],
            ),
          ),
        ),

        //Floating action button for adding todos
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => BlocProvider.value(
                value: context.read<TodoBloc>(),
                child: const AddTodoDialog(),
              ),
            ).then((_) {
              context.read<TodoBloc>().add(LoadTodo());
            });
          },
          child: const Icon(Icons.add),
        ),

        body: BlocConsumer<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state is TodoErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Error loading the todo"),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is TodoLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is TodoLoadedState) {
              if (state.todos.isEmpty) {
                return const Center(child: Text("No Todos Found"));
              }
              return SafeArea(
                child: ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    final todo = state.todos[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: ListTile(
                        leading: Checkbox(
                          value: todo.isCompleted,
                          onChanged: (_) {
                            context
                                .read<TodoBloc>()
                                .add(ToggleTodoEvent(todo: todo));
                          },
                        ),
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (todo.description.isNotEmpty)
                              Text(todo.description),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _priorityColor(
                                          todo.priority,
                                          context,
                                        ).withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    _priorityLabel(todo.priority),
                                    style: TextStyle(
                                      color: _priorityColor(
                                        todo.priority,
                                        context,
                                      ),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).colorScheme.error,
                          onPressed: () {
                            context
                                .read<TodoBloc>()
                                .add(DeleteTodoEvent(id: todo.id));
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return const Center(child: Text("Something Went Wrong"));
          },
        ),
      ),
    );
  }
}
