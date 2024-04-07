part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable{}

final class AuthInitial extends AuthState {
  @override
  List<Object?> get props =>[];
}


class AuthLoadingState extends AuthState{
  @override
  List<Object?> get props => [];
}


class AuthenticatedState extends AuthState{
  User user;
  AuthenticatedState({required this.user});
  @override
  List<Object?> get props => [user];
}

//class LoggedInState extends AuthState{
  
//   @override
//   List<Object?> get props =>[];
  
// }


class AuthenticatedErrorState extends AuthState{
  final String message;
  AuthenticatedErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}


class UnAuthenticatedState extends AuthState{
  @override
  List<Object?> get props => [];
}

class ForgotPassState extends AuthState{
  @override
  List<Object?> get props => [];

}
class PasswordResetErrorState extends AuthState {
  final String message;

  PasswordResetErrorState({required this.message});
  @override
  List<Object?> get props =>[message];
  
}
class ResetConfirmState extends AuthState {
  
  @override
  List<Object?> get props =>[];
  
}
 
