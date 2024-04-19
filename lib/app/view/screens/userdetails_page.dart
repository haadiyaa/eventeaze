import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:eventeaze/app/model/usermodel.dart';
import 'package:eventeaze/app/view/widgets/buttons/custombutton.dart';
import 'package:eventeaze/app/view/widgets/design/profile/profileavatar.dart';
import 'package:eventeaze/app/view/widgets/textfields/updatetextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  void initState() {
    super.initState();
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
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pop(context);
          });
          }
        },
        builder: (context, state) {
          final authBloc = BlocProvider.of<AuthBloc>(context);
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding:const  EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 233, 237, 201),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        ProfileAvatar(),
                        const SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          onTap: () {},
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UpdateTextField(
                                controller: _nameController!,
                                text: 'Username',
                              ),
                              UpdateTextField(
                                enabled: false,
                                controller: _emailController!,
                                text: "Email",
                              ),
                              UpdateTextField(
                                  controller: _phoneController!,
                                  text: "Phone Number"),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomButton(
                                    text: 'Done',
                                    onPressed: () {
                                      UserModel user = UserModel(
                                        uid: widget.user.uid,
                                        username: _nameController!.text.trim(),
                                        email: _emailController!.text.trim(),
                                        phone: _phoneController!.text.trim(),
                                        // image: image,
                                      );
                                      authBloc
                                          .add(UpadateUserEvent(user: user));
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
              ),
            ),
          );
        },
      ),
    );
  }
}
