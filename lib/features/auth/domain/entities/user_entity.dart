import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String? userName;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.userName,
  });

  @override
  List<Object?> get props => [uid, email, userName];
}
