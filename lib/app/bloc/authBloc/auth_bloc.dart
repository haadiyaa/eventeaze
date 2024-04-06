import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:eventeaze/app/model/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserCredential userCredential;
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_logIn);
    on<SignUpEvent>(_signUp);
    on<LogOutEvent>(_logOut);
  }

  Future<void> _logIn(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      print('loggin in process');
      userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      final user = userCredential.user;
      print('login successful');
      if (user != null) {
        emit(AuthenticatedState(user: userCredential.user!));
      }
      // emit(LoggedInState());
    } catch (e) {
      print('login errrrorrr');
      AuthenticatedErrorState(message: e.toString());
    }
  }

  Future<void> _signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    print('loading');
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: event.user.email.toString(),
          password: event.user.password.toString());
      print('created user');

      final user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'phone': event.user.phone,
          'username': event.user.username,
        });
        print('authenticated');
        emit(AuthenticatedState(user: userCredential.user!));
      } else {
        print('unauthenticated');
        emit(UnAuthenticatedState());
      }
    } catch (e) {
      print('authentication errorr1!!!!!!!!!');
      emit(AuthenticatedErrorState(message: e.toString()));
    }
  }

  Future<void> _logOut(LogOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await _auth.signOut();
      emit(UnAuthenticatedState());
    } catch (e) {
      emit(AuthenticatedErrorState(message: e.toString()));
    }
  }
}
