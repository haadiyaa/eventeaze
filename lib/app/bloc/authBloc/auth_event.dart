// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CheckLoginStatusEvent extends AuthEvent{
  
}

class OnboardEvent extends AuthEvent{
  
}

class LoginEvent extends AuthEvent{
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
  
}


class SignUpEvent extends AuthEvent{
  final UserModel user;

  SignUpEvent({required this.user});
  
}

class LogOutEvent extends AuthEvent{
}

class LogoutConfirmEvent extends AuthEvent {

  
}

class LogoutRejectEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class ForgotPassEvent extends AuthEvent{
  final String email;

  ForgotPassEvent({required this.email});

  
}
class ResetConfirmEvent extends AuthEvent {

  
}

class UpadateUserEvent extends AuthEvent {
  final UserModel user;

  UpadateUserEvent({required this.user});
  
}

class GoogleSignInEvent extends AuthEvent{
  
}
class UserImagePickEvent extends AuthEvent {
  String email;
  UserImagePickEvent({
    required this.email,
  });
  
}

