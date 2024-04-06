import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const KEYLOGIN='login';

  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Image(image: AssetImage('assets/ez.jpg')),
        ),
      ),
    );
  }
  
  void whereToGo()async{
    var sharedPref= await SharedPreferences.getInstance();
    var isLoggedIn=sharedPref.getBool(KEYLOGIN);

    Timer(const Duration(seconds: 3), () {
      if(isLoggedIn!=null){
        if (isLoggedIn==true) {
          Navigator.pushReplacementNamed(context, '/home');
        }
        else{
          Navigator.pushReplacementNamed(context, '/login');
        }
      }
      else{
        Navigator.pushReplacementNamed(context,'/onboarding');
      }
    });
  }
}
