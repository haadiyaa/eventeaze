import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:eventeaze/app/view/screens/createevent/page/createeventpage.dart';
import 'package:eventeaze/app/view/screens/authentication/login/page/login_page.dart';
import 'package:eventeaze/app/view/screens/usernotificationspage.dart';
import 'package:eventeaze/app/view/widgets/buttons/custombutton.dart';
import 'package:eventeaze/app/view/widgets/design/confirmalert.dart';
import 'package:eventeaze/app/view/screens/profilescreen/widgets/profilecard.dart';
import 'package:eventeaze/app/view/screens/profilescreen/widgets/profilelist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProfilePageWrapper extends StatelessWidget {
  const ProfilePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const ProfilePage(),
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
  User? _currentUser;

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
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginPageWrapper()),
            (route) => false,
          );
        } else if (state is AuthLoadingState) {
          showDialog(
            context: context,
            builder: (context) {
              return const Center(
                child: SpinKitFadingCircle(
                  duration: Duration(seconds: 2),
                  color: Colors.white,
                ),
              );
            },
          );
        } else if (state is LogoutConfirmState) {
          showDialog(
            context: context,
            builder: (context) => ConfirmAlert(
              icon: Icons.logout,
              iconColor: Colors.white,
              iconBgColor: Colors.amber,
              msg: 'Are you sure you want to logout?',
              onConfirm: () {
                authBloc.add(LogOutEvent());
              },
              onReject: () {
                authBloc.add(LogoutRejectEvent());
              },
            ),
          );
        } else if (state is LogoutRejectState) {
          print("ggggggggggggggggggggg");
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 25,
            title: const Text(
              'Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 68, 73, 53),
                fontSize: 24,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> UserNotificationsPage()));
                },
                icon: const Icon(
                  Icons.notifications,
                  color: Color.fromARGB(255, 68, 73, 53),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CreateEventWrapper(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add_to_photos_rounded,
                  color: Color.fromARGB(255, 68, 73, 53),
                ),
              ),
            ],
          ),
          body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(_currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitFadingCircle(
                    duration: Duration(seconds: 2),
                    color: Color.fromARGB(255, 68, 73, 53),
                  ),
                );
              }
              if (snapshot.hasData) {
                final userData = snapshot.data?.data() as Map<String, dynamic>?;
                if (userData != null) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        ProfileCard(userData: userData),
                        const SizedBox(
                          height: 10,
                        ),
                        const ProfileList(),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          text: 'Logout',
                          onPressed: () async {
                            authBloc.add(LogoutConfirmEvent());
                          },
                          color: const Color.fromARGB(255, 138, 148, 108),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      children: [
                        const Text("Null"),
                        CustomButton(
                          text: 'Logout',
                          onPressed: () async {
                            authBloc.add(LogoutConfirmEvent());
                          },
                          color: const Color.fromARGB(255, 138, 148, 108),
                        ),
                      ],
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                return Center(
                    child: Text("Error fetching user data: ${snapshot.error}"));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      },
    );
  }
}
