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

class JoinEvent extends NotificationsEvent {
  final Map<String, Object> data;
  final String seats;
  final EventModel eventdetails;
  final String userid;
  final String recieverId;
  final String title;
  final String body;

  JoinEvent({
    required this.recieverId,
    required this.userid,
    required this.eventdetails,
    required this.seats,
    required this.data,
    required this.title,
    required this.body,
  });
}
