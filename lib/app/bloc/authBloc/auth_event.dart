part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent  extends Equatable{}

class CheckLoginStatusEvent extends AuthEvent{
  @override
  List<Object?> get props => [];
  
}

class OnboardEvent extends AuthEvent{
  @override
  List<Object?> get props => [];
  
}

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

class LogoutConfirmEvent extends AuthEvent {

  @override
  List<Object?> get props => [];
  
}

class LogoutRejectEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class ForgotPassEvent extends AuthEvent{
  final String email;

  ForgotPassEvent({required this.email});

  @override
  List<Object?> get props => [email];
  
}
class ResetConfirmEvent extends AuthEvent {

  @override
  List<Object?> get props => [];
  
}

class UpadateUserEvent extends AuthEvent {
  final UserModel user;

  UpadateUserEvent({required this.user});
  
  @override
  List<Object?> get props => [user];
}

