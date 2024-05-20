import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:eventeaze/app/view/screens/authentication/onboarding/page/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: LottieBuilder.asset('assets/lottie/Animation - 1714368404544.json'),)
          ],
        ),
      ),
      nextScreen: const SplashScreen(),
      backgroundColor: Colors.white,
      splashIconSize: 400,
    );
  }
}
