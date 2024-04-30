import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:eventeaze/app/model/usermodel.dart';
import 'package:eventeaze/app/view/widgets/buttons/custombutton.dart';
import 'package:eventeaze/app/view/widgets/design/profile/profileavatar.dart';
import 'package:eventeaze/app/view/widgets/textfields/updatetextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final _formKey = GlobalKey<FormState>();

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
            Navigator.pop(context);
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
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                data['image'] == null
                                    ? state is ImageLoadingState
                                        ? Shimmer.fromColors(
                                            baseColor: const Color.fromARGB(
                                                255, 180, 192, 142),
                                            highlightColor:
                                                const Color.fromARGB(
                                                    255, 230, 247, 182),
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
                                        child: CachedNetworkImage(
                                          imageUrl: data['image'],
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Shimmer.fromColors(
                                            baseColor: const Color.fromARGB(
                                                255, 180, 192, 142),
                                            highlightColor:
                                                const Color.fromARGB(
                                                    255, 230, 247, 182),
                                            child: Container(
                                              width: 10,
                                              height: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
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
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      UpdateTextField(
                                        inputFormatters: [LengthLimitingTextInputFormatter(25),FilteringTextInputFormatter.deny(RegExp(r'\s{2,}'))],
                                        keyboardType: TextInputType.name,
                                        autovalidateMode: autovalidateMode,
                                        validator: (value) {
                                          final name =
                                              RegExp(r'^[A-Za-z\s]{3,}[\s]*$');
                                          if (value!.isEmpty) {
                                            return 'User name can\'t be empty';
                                          } else if (!name.hasMatch(value)) {
                                            return "Enter a valid name";
                                          }
                                        },
                                        controller: _nameController!,
                                        text: 'Username',
                                      ),
                                      UpdateTextField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter.deny(
                                                RegExp(r'\s')),
                                            LengthLimitingTextInputFormatter(
                                                10),
                                          ],
                                          keyboardType: TextInputType.phone,
                                          autovalidateMode: autovalidateMode,
                                          validator: (value) {
                                            final reg2 =
                                                RegExp(r"^[6789]\d{9}[\s]*$");
                                            if (value!.isEmpty) {
                                              return 'Number can\'t be empty';
                                            } else if (value.trim().length >
                                                10) {
                                              return "number exact 10";
                                            } else if (!reg2.hasMatch(value)) {
                                              return 'Enter a valid phone number';
                                            }
                                          },
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
                                              autovalidateMode =
                                                  AutovalidateMode
                                                      .onUserInteraction;
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                UserModel user = UserModel(
                                                  uid: widget.user.uid,
                                                  username: _nameController!
                                                      .text
                                                      .trim(),
                                                  email: _emailController!.text
                                                      .trim(),
                                                  phone: _phoneController!.text
                                                      .trim(),
                                                  image: data['image'],
                                                );
                                                authBloc.add(UpadateUserEvent(
                                                    user: user));
                                              }
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
