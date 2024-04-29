import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(CheckLoginStatusEvent()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            Navigator.pushReplacementNamed(context, '/tabs');
          } else if (state is UnAuthenticatedState) {
            Navigator.pushReplacementNamed(context, '/login');
          } else if (state is GetStartedState) {
            Navigator.pushReplacementNamed(context, '/onboarding');
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: Shimmer.fromColors(
                loop:10,
                baseColor:const Color.fromARGB(255, 63, 85, 49),
                highlightColor:const Color.fromARGB(255, 105, 158, 100),
                child: const Text(
                  'EventEaze',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
