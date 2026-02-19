import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/presentation/bloc/todo_state.dart';
import '../bloc/todo_bloc.dart';

class TodoPageView extends StatefulWidget {
  const TodoPageView({super.key});

  @override
  State<TodoPageView> createState() => _TodoPageViewState();
}

class _TodoPageViewState extends State<TodoPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TodoBloc,TodoState>( listener: (context,state){
        if(state is TodoErrorState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Error loading the todo"),
            backgroundColor: Colors.red,
          ));
        }
      },builder: (context,state){
        if(state is TodoLoadingState){
          return Center(child: CircularProgressIndicator());
        }
        return SafeArea(
          child: Column(
            children: [
              
            ],
          ),
        );
      }),
    );
  }
}
