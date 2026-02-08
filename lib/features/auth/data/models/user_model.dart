import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends UserEntity {
  const UserModel({required super.uid, required super.email, super.userName, super.password,});

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      userName: user.displayName,
    );
  }

  factory UserModel.fromFirestore(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      userName: json['username'],
      password: json['password']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid':uid,
      'email':email,
      'username':userName,
      'password':password,
      'createdAt':FieldValue.serverTimestamp()
    };
  }

  UserEntity toEntity() {
    return UserEntity(uid: uid, email: email, userName: userName, password: password,);
  }
}
