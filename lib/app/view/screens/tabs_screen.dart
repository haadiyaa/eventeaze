import 'package:eventeaze/app/bloc/bottonNavbloc/bottomnav_bloc.dart';
import 'package:eventeaze/app/utils/notificationservices.dart';
import 'package:eventeaze/app/view/screens/categoriespage.dart';
import 'package:eventeaze/app/view/screens/homepage.dart';
import 'package:eventeaze/app/view/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TabsScreenWrapper extends StatelessWidget {
  const TabsScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomnavBloc(),
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

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    // notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      print('Device Token : $value');
    });
  }

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
