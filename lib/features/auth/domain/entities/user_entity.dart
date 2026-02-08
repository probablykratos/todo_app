import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String? userName;
  final String? password;
  const UserEntity({
    required this.uid,
    required this.email,
    required this.userName,
    required this.password
  });

  @override
  List<Object?> get props => [uid, email, userName,password];
}
