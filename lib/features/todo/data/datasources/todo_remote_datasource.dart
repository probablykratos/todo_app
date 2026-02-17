import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/core/error/exceptions.dart';
import 'package:todo/core/error/failures.dart';

import '../model/todo_model.dart';

abstract class TodoRemoteDatasource {
  Future<List<TodoModel>> getTodo();
  Future<TodoModel> getTodoById(String id);
  Future<void> createTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);

  Stream<List<TodoModel>> watchTodos();
}

class TodoRemoteDataSourceImpl implements TodoRemoteDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  TodoRemoteDataSourceImpl({required this.firestore, required this.auth});

  String get _userId {
    final user = auth.currentUser;

    if (user == null) {
      throw ServerFailure();
    }
    return user.uid;
  }

  CollectionReference get _todosCollection =>
      firestore.collection('users').doc(_userId).collection('todos');

  @override
  Future<void> createTodo(TodoModel todo) async{
    try{
      await _todosCollection.doc(todo.id).set(todo.toFirestore());
    }catch(e){
      throw ServerFailure();
    }
  }

  @override
  Future<void> deleteTodo(String id)async {
    try{
      await _todosCollection.doc(id).delete();
    }catch(e){
      throw ServerFailure();
    }
  }

  @override
  Future<List<TodoModel>> getTodo() async {
    try {
      final querySnapShot = await _todosCollection
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapShot.docs
          .map((doc) => TodoModel.fromFirestore(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<TodoModel> getTodoById(String id) async {
    try {
      final doc = await _todosCollection.doc(id).get();

      if (!doc.exists) {
        throw ServerException();
      }

      return TodoModel.fromFirestore(doc);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    try {
      await _todosCollection.doc(todo.id).update(todo.toFirestore());
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Stream<List<TodoModel>> watchTodos() {
    try {
      return  _todosCollection
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => TodoModel.fromFirestore(doc))
                .toList(),
          );
    } catch (e) {
      throw ServerFailure();
    }
  }
}
