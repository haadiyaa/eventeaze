import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eventeaze/app/bloc/notificationsBloc/notifications_bloc.dart';
import 'package:eventeaze/app/bloc/bottonNavbloc/bottomnav_bloc.dart';
import 'package:eventeaze/app/serivices/notificationservices.dart';
import 'package:eventeaze/app/view/screens/categoriesscreen/page/categoriespage.dart';
import 'package:eventeaze/app/view/screens/homescreen/page/homepage.dart';
import 'package:eventeaze/app/view/screens/profilescreen/page/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class TabsScreenWrapper extends StatelessWidget {
  const TabsScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomnavBloc(),
        ),
        BlocProvider(
          create: (context) => NotificationsBloc(),
        ),
      ],
      child: TabsScreen(),
    );
  }
}

class TabsScreen extends StatefulWidget {
  TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  NotificationServices notificationServices = NotificationServices();
  String mToken = '';
  User? user;

  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
    getConnectivity();
    user = FirebaseAuth.instance.currentUser;
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    // notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      BlocProvider.of<NotificationsBloc>(context).add(GetTokenEvent(currentUser: user!, token: value));
      mToken = value;

      print('Device Token : $value');
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  showDialogBox() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your Internet Connection'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                setState(() {
                  isAlertSet = false;
                });
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  showDialogBox();
                  setState(() {
                    isAlertSet = true;
                  });
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

  getConnectivity() => subscription =
          Connectivity().onConnectivityChanged.listen((result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() {
            isAlertSet = true;
          });
        }
      });

  List<Widget> pages = [
    const HomePageWrapper(),
    CategoriesPage(),
    const ProfilePageWrapper(),
  ];

  List<GButton> bottomNavItems = const [
    GButton(
      icon: Icons.home,
      text: 'Home',
    ),
    GButton(
      icon: Icons.category,
      text: 'Categories',
    ),
    GButton(
      icon: Icons.person,
      text: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomnavBloc, BottomnavState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: pages.elementAt(state.tabIndex),
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 113, 121, 89),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: GNav(
                gap: 8,
                tabs: bottomNavItems,
                backgroundColor: const Color.fromARGB(255, 113, 121, 89),
                color: const Color.fromARGB(255, 64, 68, 50),
                activeColor: Colors.white,
                tabBackgroundColor: const Color.fromARGB(255, 162, 173, 127),
                padding: const EdgeInsets.all(10),
                duration: const Duration(microseconds: 500),
                selectedIndex: state.tabIndex,
                onTabChange: (index) {
                  BlocProvider.of<BottomnavBloc>(context)
                      .add(TabChangeEvent(tabIndex: index));
                },
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
