part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthenticatedState extends AuthState {
  User user;
  AuthenticatedState({required this.user});
  @override
  List<Object?> get props => [user];
}

class AuthenticatedErrorState extends AuthState {
  final String message;
  AuthenticatedErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class GetStartedState extends AuthState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticatedState extends AuthState {
  @override
  List<Object?> get props => [];
}

class LogoutConfirmState extends AuthState {
  @override
  List<Object?> get props => [];
}

class LogoutRejectState extends AuthState {
  @override
  List<Object?> get props => [];
}

class ForgotPassState extends AuthState {
  @override
  List<Object?> get props => [];
}

class PasswordResetErrorState extends AuthState {
  final String message;

  PasswordResetErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class ResetConfirmState extends AuthState {
  @override
  List<Object?> get props => [];
}

class UpdateUserState extends AuthState {
  @override
  List<Object?> get props => [];
}

class UpdationErrorState extends AuthState {
  final String message;

  UpdationErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class GoogleSignInState extends AuthState {
  User user;
  GoogleSignInState({
    required this.user,
  });
  
  @override
  List<Object?> get props => [user];
  
}
class GoogleSignInErrorState extends AuthState {
  final String message;

  GoogleSignInErrorState({required this.message});
  
  @override
  List<Object?> get props => [];

}
class UserImagePickState extends AuthState {
   final String image;

  UserImagePickState({required this.image});
  @override
  List<Object?> get props => [];
  
}
class ImageLoadingState extends AuthState{
  @override
  List<Object?> get props => [];
  
}
class ImagePickErrorState extends AuthState {
  final String message;

  ImagePickErrorState({required this.message});
  // @override
  // List<Object?> get props => [];
  
}


