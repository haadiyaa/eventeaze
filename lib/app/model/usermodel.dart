import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  String? uid;
  String? username;
  String? password;
  String? email;
  String? phone;

  UserModel({
    this.uid,
    this.phone, 
    this.username,
    this.password,
    this.email,
  });

  @override
  List<Object?> get props => [
        uid,
        username,
        password,
        email,
        phone,
      ];
}
