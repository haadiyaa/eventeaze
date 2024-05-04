part of 'notifications_bloc.dart';

sealed class NotificationsEvent {
  const NotificationsEvent();
}

class GetTokenEvent extends NotificationsEvent {
  final String token;
  final String email;

  GetTokenEvent({required this.email, required this.token});
}
