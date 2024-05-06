import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final User? user=FirebaseAuth.instance.currentUser;
  NotificationsBloc() : super(NotificationsInitial()) {
    on<GetTokenEvent>(_getToken);
    on<NetwoekEvent>(_network);

  }

  Future<FutureOr<void>> _getToken(GetTokenEvent event, Emitter<NotificationsState> emit) async {
    await FirebaseFirestore.instance.collection('deviceToken').doc(event.currentUser.uid).set({
      'token':event.token,
    });
    print('event: ${event.token}');
    emit(GetTokenState(token: event.token));
  }
   FutureOr<void> _network(NetwoekEvent event, Emitter<NotificationsState> emit) {
    emit(NetworkState(value: event.value));
  }
}
