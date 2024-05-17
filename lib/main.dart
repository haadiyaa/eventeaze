import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/view/screens/homescreen/page/homepage.dart';
import 'package:eventeaze/app/view/screens/authentication/login/page/login_page.dart';
import 'package:eventeaze/app/view/screens/authentication/onboarding/page/onbording_screen.dart';
import 'package:eventeaze/app/view/screens/splash.dart';
import 'package:eventeaze/app/view/screens/tabs_screen.dart';
import 'package:eventeaze/app/view/screens/usereventspage.dart';
import 'package:eventeaze/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: false);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
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
        '/onboarding': (context) => const OnBoardingWrapper(),
        '/login': (context) => const LoginPageWrapper(),
        '/home': (context) => const HomePageWrapper(),
        '/tabs': (context) => const TabsScreenWrapper(),
        '/eventlist': (context) => UserEventsPage(),
        
      },
    );
  }
}
