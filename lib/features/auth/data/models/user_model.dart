import 'package:todo/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(super.id, super.email, super.name);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['id'] as String,
      json['email'] as String,
      json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }
}