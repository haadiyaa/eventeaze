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

class JoinEventState extends NotificationsState{

}
class JoinLoadingState extends NotificationsState{

}

class JoinEventErrorState extends NotificationsState{
  final String message;

  JoinEventErrorState({required this.message});
}