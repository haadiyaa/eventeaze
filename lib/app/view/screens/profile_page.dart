import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:eventeaze/app/view/screens/login_page.dart';
import 'package:eventeaze/app/view/screens/splashscreen.dart';
import 'package:eventeaze/app/view/widgets/buttons/custombutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePageWrapper extends StatelessWidget {
  const ProfilePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.user});

  final User? user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  dynamic _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticatedState) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => LoginPageWrapper()));
          });
        }
      },
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 25,
            title: const Text(
              'Profile',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 68, 73, 53),
                  fontSize: 24),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: Color.fromARGB(255, 68, 73, 53),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add_to_photos_rounded,
                  color: Color.fromARGB(255, 68, 73, 53),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 233, 237, 201),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Color.fromARGB(255, 68, 73, 53),
                                ),
                              ),
                              Text('email'),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_circle_right_rounded,
                            color: Color.fromARGB(255, 68, 73, 53),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Expanded(
                //   child: ListView.separated(
                //     itemCount: 5,
                //     separatorBuilder: (BuildContext context, int index) {
                //       return const Divider();
                //     },
                //     itemBuilder: (BuildContext context, int index) {
                //       return ListTile();
                //     },
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: 'Logout',
                  onPressed: () async {
                    var sharedPref = await SharedPreferences.getInstance();
                    sharedPref.setBool(SplashScreenState.KEYLOGIN, false);
                    authBloc.add(LogOutEvent());
                  },
                  color: const Color.fromARGB(255, 138, 148, 108),
                ),
                CustomButton(
                  foreground: const Color.fromARGB(255, 138, 148, 108),
                  text: 'Delete Account',
                  onPressed: () {},
                  color: const Color.fromARGB(255, 233, 237, 201),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
