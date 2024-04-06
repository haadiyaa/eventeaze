part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent  extends Equatable{}

class LoginEvent extends AuthEvent{
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
  
  @override
  List<Object?> get props =>[email,password];
  
}


class SignUpEvent extends AuthEvent{
  final UserModel user;

  SignUpEvent({required this.user});
  
  @override
  List<Object?> get props => [user];
}

class LogOutEvent extends AuthEvent{
  @override
  List<Object?> get props => [];
}