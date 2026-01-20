import 'dart:convert';

import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  Future<String> getCachedToken();
  Future<void> clearToken();
  Future<void> cacheUser(UserModel user);
  Future<UserModel> getCachedUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String cachedToken = 'CACHED TOKEN';
  static const String cachedUser = 'CACHED USER';

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheToken(String token) async {
    await sharedPreferences.setString(cachedToken, token);
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    await sharedPreferences.setString(cachedUser, json.encode(user.toJson()));
  }

  @override
  Future<void> clearToken() async {
    await sharedPreferences.remove(cachedToken);
    await sharedPreferences.remove(cachedUser);
  }

  @override
  Future<String> getCachedToken() async {
    final token = sharedPreferences.getString(cachedToken);
    if (token == null) {
      throw Exception('No cached token found');
    }
    return token;
  }

  @override
  Future<UserModel> getCachedUser() async {
    final userJson = sharedPreferences.getString(cachedUser);
    if (userJson == null) {
      throw Exception("No cached user found");
    }
    return UserModel.fromJson(json.decode(userJson) as Map<String, dynamic>);
  }
}
