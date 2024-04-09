import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:eventeaze/app/view/screens/deleteaccount.dart';
import 'package:eventeaze/app/view/screens/login_page.dart';
import 'package:eventeaze/app/view/screens/splashscreen.dart';
import 'package:eventeaze/app/view/widgets/buttons/custombutton.dart';
import 'package:eventeaze/app/view/widgets/design/confirmalert.dart';
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
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => LoginPageWrapper()));
          });
        }
        if (state is LogoutConfirmState) {
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
                      Navigator.pop(context);
                    },
                  ));
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
          body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(_currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                final userData = snapshot.data?.data() as Map<String, dynamic>;
                if (userData != null) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
                              Expanded(
                                flex: 4,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color.fromARGB(
                                              255, 184, 197, 146),
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 68, 73, 53)),
                                          boxShadow: const [
                                            BoxShadow(
                                                blurRadius: 7,
                                                offset: Offset(0, 7),
                                                color: Colors.grey),
                                          ],
                                        ),
                                        // child: Icon(Icons.perso),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            userData['username'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                              color: Color.fromARGB(
                                                  255, 68, 73, 53),
                                            ),
                                          ),
                                          Text(userData['email']),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_circle_right_rounded,
                                      color: Color.fromARGB(255, 68, 73, 53),
                                    ),
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
                            authBloc.add(LogoutConfirmEvent());
                          },
                          color: const Color.fromARGB(255, 138, 148, 108),
                        ),
                        CustomButton(
                          foreground: const Color.fromARGB(255, 138, 148, 108),
                          text: 'Delete Account',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DeleteWrapper()));
                          },
                          color: const Color.fromARGB(255, 233, 237, 201),
                        ),
                      ],
                    ),
                  );
                }
              }
              return Container();
            },
          ),
        );
      },
    );
  }
}
