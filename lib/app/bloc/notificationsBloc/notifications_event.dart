part of 'notifications_bloc.dart';

sealed class NotificationsEvent {
  const NotificationsEvent();
}

class GetTokenEvent extends NotificationsEvent {
  final String token;
  final User currentUser;

  GetTokenEvent({required this.currentUser, required this.token});
}

class NetwoekEvent extends NotificationsEvent {
  final bool value;

  NetwoekEvent({required this.value});
}

class JoinEvent extends NotificationsEvent{
  final Map<String, Object> data;
  final String seats;
  final String id;

  JoinEvent({required this.id, required this.seats, required this.data});
}
