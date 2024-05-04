part of 'notifications_bloc.dart';

sealed class NotificationsState{
  const NotificationsState();
}

final class NotificationsInitial extends NotificationsState {}

class GetTokenState extends NotificationsState {
  final String token;

  GetTokenState({required this.token});
}