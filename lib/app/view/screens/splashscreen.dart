import 'dart:async';

import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(CheckLoginStatusEvent()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            Navigator.pushReplacementNamed(context, '/tabs');
          }
          else if(state is UnAuthenticatedState){
            Navigator.pushReplacementNamed(context, '/login');
          }
          else if(state is GetStartedState){
            Navigator.pushReplacementNamed(context, '/onboarding');
          }
        },
        child: const Scaffold(
          body: SafeArea(
            child: Center(
              child: Image(image: AssetImage('assets/ez.jpg')),
            ),
          ),
        ),
      ),
    );
  }

}
