import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:eventeaze/app/model/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static const KEYLOGIN = 'login';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserCredential userCredential;
  AuthBloc() : super(AuthInitial()) {
    on<CheckLoginStatusEvent>(_checkStatus);
    on<OnboardEvent>(_onBoard);
    on<LoginEvent>(_logIn);
    on<SignUpEvent>(_signUp);
    on<LogOutEvent>(_logOut);
    on<LogoutConfirmEvent>(_logOutConfirm);
    on<ForgotPassEvent>(_forgotPass);
    on<ResetConfirmEvent>(_resetConfirm);
    on<DeleteAccountEvent>(_deleteAccount);
    on<DeleteConfirmEvent>(_deleteConfim);
  }

  Future<void> _deleteAccount(
      DeleteAccountEvent event, Emitter<AuthState> emit) async {
    User? user = _auth.currentUser;
    try {
      AuthCredential credential = EmailAuthProvider.credential(
          email: event.email, password: event.password);
      await user!.reauthenticateWithCredential(credential).then((value) async {
        await value.user!.delete().then((value) async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .delete()
              .then((value) {
            emit(DeleteAccountState());
          });
        });
      });
    } catch (e) {
      emit(DeleteAccountErrorState(message: e.toString()));
    }
  }

  Future<void> _onBoard(OnboardEvent event, Emitter<AuthState> emit) async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(KEYLOGIN, false);
    emit(GetStartedState());
  }

  Future<void> _checkStatus(
      CheckLoginStatusEvent event, Emitter<AuthState> emit) async {
    User? user;
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);

    try {
      await Future.delayed(const Duration(seconds: 3));
      if (isLoggedIn == null) {
        emit(GetStartedState());
      } else {
        user = _auth.currentUser;
        if (user != null) {
          emit(AuthenticatedState(user: user));
        } else {
          emit(UnAuthenticatedState());
        }
      }
    } catch (e) {
      emit(AuthenticatedErrorState(message: e.toString()));
    }
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
        emit(AuthenticatedState(user: user));
        var sharedPref = await SharedPreferences.getInstance();
        sharedPref.setBool(KEYLOGIN, true);
      } else {
        emit(UnAuthenticatedState());
      }
    } catch (e) {
      print('Error occurred: $e');
      emit(AuthenticatedErrorState(message: e.toString()));
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
          // 'image':event.user.image,
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
    try {
      await _auth.signOut().then((value) {
        emit(UnAuthenticatedState());
      });
      var sharedPref = await SharedPreferences.getInstance();
      sharedPref.setBool(KEYLOGIN, false);
    } catch (e) {
      emit(AuthenticatedErrorState(message: e.toString()));
    }
  }

  Future<void> _forgotPass(
      ForgotPassEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await _auth
          .sendPasswordResetEmail(email: event.email)
          .then((value) => emit(ForgotPassState()));
    } catch (e) {
      emit(PasswordResetErrorState(message: e.toString()));
    }
  }

  void _resetConfirm(ResetConfirmEvent event, Emitter<AuthState> emit) {
    emit(ResetConfirmState());
  }

  FutureOr<void> _deleteConfim(
      DeleteConfirmEvent event, Emitter<AuthState> emit) {
        emit(DeleteAccountConfirmState());
      }

  FutureOr<void> _logOutConfirm(LogoutConfirmEvent event, Emitter<AuthState> emit) {
    emit(LogoutConfirmState());
  }
}
