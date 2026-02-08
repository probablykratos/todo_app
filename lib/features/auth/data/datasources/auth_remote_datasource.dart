import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithEmail(String email, String password);
  Future<UserModel> signUpWithEmail(
    String email,
    String password,
    String username,
  );
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user =userCredential.user;

      if (user == null) {
        throw ServerException();
      }

      final doc =await firestore.collection('users').doc(user.uid).get();

      if(doc.exists){
        return UserModel.fromFirestore(doc.data()!);
      }
      else{
        return UserModel.fromFirebaseUser(userCredential.user!);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential' ||
          e.code == 'invalid-email') {
        throw InvalidCredentialException();
      } else if (e.code == 'too-many-requests') {
        throw ServerException();
      } else if (e.code == 'network-request-failed') {
        throw ServerException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> signUpWithEmail(
    String email,
    String password,
    String username,
  ) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user == null) {
        throw ServerException();
      }

      final userModel = UserModel(
        uid: user.uid,
        email: user.email ?? email,
        userName: username,
        password: password
      );
      await firestore
          .collection('users')
          .doc(user.uid)
          .set(userModel.toFirestore());
      return userModel;


    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw InvalidCredentialException();
      } else if (e.code == 'email-already-in-use') {
        throw InvalidCredentialException();
      } else if (e.code == 'invalid-email') {
        throw InvalidCredentialException();
      } else if (e.code == 'network-request-failed') {
        throw ServerException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) return null;

      final doc =
      await firestore.collection('users').doc(user.uid).get();

      if (!doc.exists) return null;

      return UserModel.fromFirestore(doc.data()!);
    } catch (e) {
      throw ServerException();
    }
  }
}
