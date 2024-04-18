import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:eventeaze/app/model/usermodel.dart';
import 'package:eventeaze/app/view/screens/createeventpage.dart';
import 'package:eventeaze/app/view/screens/login_page.dart';
import 'package:eventeaze/app/view/screens/userdetails_page.dart';
import 'package:eventeaze/app/view/widgets/buttons/custombutton.dart';
import 'package:eventeaze/app/view/widgets/design/confirmalert.dart';
import 'package:eventeaze/app/view/widgets/design/profileavatar.dart';
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
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const LoginPageWrapper()));
          });
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
                  ),);
        } else if (state is LogoutRejectState) {print("ggggggggggggggggggggg");
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pop(context);
          });
          
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
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: Color.fromARGB(255, 68, 73, 53),
                ),
              ),
              IconButton(
                onPressed: () {
                  // authBloc.add(OnCreateButtonClickedEvent());
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const CreateEventWrapper()));
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
                                      child: ProfileAvatar(),
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
                                    onPressed: () {
                                      final user = UserModel(
                                        uid: userData['uid'],
                                        email: userData['email'],
                                        phone: userData['phone'],
                                        username: userData['username'],
                                        // image: userData['image'],
                                      );
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  UserDetailsPageWrapper(
                                                    user: user,
                                                  )));
                                    },
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
