part of 'notifications_bloc.dart';

sealed class NotificationsState{
  const NotificationsState();
}

final class NotificationsInitial extends NotificationsState {}

class GetTokenState extends NotificationsState {
  final String token;

  GetTokenState({required this.token});
}
class NetworkState extends NotificationsState {
  final bool value;

  NetworkState({required this.value});
}