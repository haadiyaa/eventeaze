import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/model/evenmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final User? user = FirebaseAuth.instance.currentUser;
  NotificationsBloc() : super(NotificationsInitial()) {
    on<GetTokenEvent>(_getToken);
    on<NetwoekEvent>(_network);
    on<JoinEvent>(_join);
  }

  Future<FutureOr<void>> _getToken(
      GetTokenEvent event, Emitter<NotificationsState> emit) async {
    await FirebaseFirestore.instance
        .collection('deviceToken')
        .doc(event.currentUser.uid)
        .set({
      'token': event.token,
    });
    print('event: ${event.token}');
    emit(GetTokenState(token: event.token));
  }

  FutureOr<void> _network(
      NetwoekEvent event, Emitter<NotificationsState> emit) {
    emit(NetworkState(value: event.value));
  }

  Future<FutureOr<void>> _join(
      JoinEvent event, Emitter<NotificationsState> emit) async {
        emit(JoinLoadingState());
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          body: jsonEncode(event.data),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':
                'key=AAAAd9zIxEE:APA91bGeFb3CY_PAjpSaIc_xvR7GYtSOy0n2n4zn7o5W_rs034TapwJZ_sgwE0l4mOoXPndnQTd-P1yo7ARIF7rPkhh-BnMHtu59XfM7gvDFZriH03WcGtCp6xFNnhIxul2qINI4bZTu',
          }).whenComplete(() async {
            await FirebaseFirestore.instance.collection('events').doc(event.eventdetails.eventId).update({'seats':(int.parse(event.seats)-1).toString()});
          }).then((value) {
            FirebaseFirestore.instance.collection('users').doc(event.userid).collection('myevents').doc(event.eventdetails.eventId).set({
              'eventId':event.eventdetails.eventId,
              'bookingTime':DateTime.now(),
              'eventName':event.eventdetails.eventName,
              'eventTime':event.eventdetails.eventTime,
              'eventDate':event.eventdetails.eventDate,
              'venue':event.eventdetails.venue,
              'location':event.eventdetails.location,
              'contact':event.eventdetails.contact,
              'price':event.eventdetails.ticketPrice,
              'image':event.eventdetails.image,
            });
          })
          .then((value) => emit(JoinEventState()));
          
    } catch (e) {
      emit(JoinEventErrorState(message: e.toString()));
    }
  }
}
