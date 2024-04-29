import 'package:eventeaze/app/view/screens/homepage.dart';
import 'package:eventeaze/app/view/screens/login_page.dart';
import 'package:eventeaze/app/view/screens/onbording_screen.dart';
import 'package:eventeaze/app/view/screens/splash.dart';
import 'package:eventeaze/app/view/screens/tabs_screen.dart';
import 'package:eventeaze/app/view/screens/usereventspage.dart';
import 'package:eventeaze/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      title: 'EventEaze',
      home: const Splash(),
      routes: {
        '/onboarding':(context) => const OnBoardingWrapper(),
        '/login':(context) => const LoginPageWrapper(),
        '/home':(context) => const HomePageWrapper(),
        '/tabs':(context) => const TabsScreenWrapper(),
        '/eventlist':(context) =>  UserEventsPage(),
      },
    );
  }
}
