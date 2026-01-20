import 'dart:async';
import 'package:todo/core/error/exceptions.dart';
import 'package:todo/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> login(String email,String password);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDatasource{
  @override
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));

    if(email =="test@gmail.com" && password =="password"){
      return UserModel("1", "test@gmail.com", "test");
    }
    else{
      throw InvalidCredentialException();
    }
  }

  @override
  Future<void> logout() async {
    await Future.delayed(Duration(seconds: 2));
  }

}