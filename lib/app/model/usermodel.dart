
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  String? uid;
  String? username;
  String? password;
  String? email;
  String? phone;
  String? image;

  UserModel({
    this.uid,
    this.phone, 
    this.username,
    this.password,
    this.email,
    this.image,
  });

  @override
  List<Object?> get props => [
        uid,
        username,
        password,
        email,
        phone,
        image
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'password': password,
      'email': email,
      'phone': phone,
      // 'image': image,
    };
  }


}
