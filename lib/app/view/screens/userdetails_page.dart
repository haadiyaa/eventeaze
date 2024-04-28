import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:eventeaze/app/model/usermodel.dart';
import 'package:eventeaze/app/view/widgets/buttons/custombutton.dart';
import 'package:eventeaze/app/view/widgets/design/profile/profileavatar.dart';
import 'package:eventeaze/app/view/widgets/textfields/updatetextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class UserDetailsPageWrapper extends StatelessWidget {
  const UserDetailsPageWrapper({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: UserDetailsPage(
        user: user,
      ),
    );
  }
}

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key, required this.user});
  final UserModel user;

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  String? image;
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _phoneController;
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser!;
    _emailController = TextEditingController(text: widget.user.email);
    _nameController = TextEditingController(text: widget.user.username);
    _phoneController = TextEditingController(text: widget.user.phone);
    // image = widget.user.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 68, 73, 53),
              fontSize: 24),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UpdateUserState) {
            // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pop(context);
            // });
          } else if (state is UserImagePickState) {
            image = state.image;
          }
        },
        builder: (context, state) {
          final authBloc = BlocProvider.of<AuthBloc>(context);
          return SingleChildScrollView(
            child: Center(
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data?.data() as Map<String, dynamic>?;
                    if (data != null) {
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 233, 237, 201),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  _emailController!.text,
                                  style: TextStyle(fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                data['image'] == null
                                    ? state is ImageLoadingState
                                        ? Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: Container(
                                              clipBehavior: Clip.antiAlias,
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
                                                      offset: Offset(0, 4),
                                                      color: Colors.grey),
                                                ],
                                              ),
                                            ),
                                          )
                                        : ProfileAvatar()
                                    : ProfileAvatar(
                                        child: Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(data['image']),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 8,
                                ),
                                InkWell(
                                  onTap: () {
                                    authBloc.add(UserImagePickEvent(
                                        email: _currentUser.email!));
                                  },
                                  child: const Text(
                                    'Edit Picture',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 68, 73, 53),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Form(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      UpdateTextField(
                                        controller: _nameController!,
                                        text: 'Username',
                                      ),
                                      // UpdateTextField(
                                      //   enabled: false,
                                      //   controller: _emailController!,
                                      //   text: "Email",
                                      // ),
                                      UpdateTextField(
                                          controller: _phoneController!,
                                          text: "Phone Number"),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomButton(
                                            text: 'Done',
                                            onPressed: () {
                                              UserModel user = UserModel(
                                                uid: widget.user.uid,
                                                username: _nameController!.text
                                                    .trim(),
                                                email: _emailController!.text
                                                    .trim(),
                                                phone: _phoneController!.text
                                                    .trim(),
                                                image: data['image'],
                                              );
                                              authBloc.add(
                                                  UpadateUserEvent(user: user));
                                            },
                                            color: const Color.fromARGB(
                                                255, 138, 148, 108),
                                            child: state == AuthLoadingState
                                                ? const CircularProgressIndicator()
                                                : null,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  }
                  return Container();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
