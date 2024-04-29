part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {
}

class AuthLoadingState extends AuthState {
}

class AuthenticatedState extends AuthState {
  final User user;
  AuthenticatedState({required this.user});
}

class AuthenticatedErrorState extends AuthState {
  final String message;
  AuthenticatedErrorState({required this.message});
}

class GetStartedState extends AuthState {
}

class UnAuthenticatedState extends AuthState {
}

class LogoutConfirmState extends AuthState {
}

class LogoutRejectState extends AuthState {
}

class ForgotPassState extends AuthState {
}

class PasswordResetErrorState extends AuthState {
  final String message;

  PasswordResetErrorState({required this.message});
}

class ResetConfirmState extends AuthState {
}

class UpdateUserState extends AuthState {

}

class UpdationErrorState extends AuthState {
  final String message;

  UpdationErrorState({required this.message});
}

class GoogleSignInState extends AuthState {
  final User user;
  GoogleSignInState({
    required this.user,
  });
  
}
class GoogleSignInErrorState extends AuthState {
  final String message;

  GoogleSignInErrorState({required this.message});

}
class UserImagePickState extends AuthState {
   final String image;

  UserImagePickState({required this.image});
  
}
class ImageLoadingState extends AuthState{
  
}
class ImagePickErrorState extends AuthState {
  final String message;

  ImagePickErrorState({required this.message});
}


