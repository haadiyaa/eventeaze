import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:eventeaze/app/view/widgets/buttons/custombutton.dart';
import 'package:eventeaze/app/view/widgets/customtextfield.dart';
import 'package:eventeaze/app/view/widgets/design/confirmalert.dart';
import 'package:eventeaze/app/view/widgets/design/customalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteWrapper extends StatelessWidget {
  const DeleteWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: DeleteAccountPage(),
    );
  }
}

class DeleteAccountPage extends StatelessWidget {
  DeleteAccountPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is DeleteAccountConfirmState) {
          showDialog(
            context: context,
            builder: (context) {
              return ConfirmAlert(
                msg: 'Are you sure you want to delete this account?',
                icon: Icons.warning_rounded,
                iconColor: Colors.red,
                iconBgColor:const Color.fromARGB(255, 255, 221, 221),
                onConfirm: () {
                  authBloc.add(DeleteAccountEvent(
                      password: _passwordController.text.trim(),
                      email: _emailController.text.trim()));
                },
                onReject: () {
                  Navigator.pop(context);
                },
              );
            },
          );
        }
        if (state is DeleteAccountState) {
          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        } else if (state is DeleteAccountErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text('Could\'nt delete this account')));
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  padding:const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 233, 237, 201),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Delete Account',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 68, 73, 53),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        'This action is irreversible and will permanently delete all your account information.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Color.fromARGB(255, 68, 73, 53),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _emailController,
                              hintText: 'Email address',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email is required";
                                }
                                final emailReg = RegExp(
                                    r"^[a-zA-Z0-9_\-\.\S]{4,}[@][a-z]+[\.][a-z]{2,3}[\s]*$");
                                if (!emailReg.hasMatch(value)) {
                                  return 'Invalid email address!';
                                }
                              },
                            ),
                            CustomTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                              validator: (value) {
                                final paswd = RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                if (value!.isEmpty) {
                                  return 'please enter the password';
                                } else if (!paswd.hasMatch(value)) {
                                  return 'Password should contain at least one upper case, \none lower case, one digit, one special character and \nmust be 8 characters in length';
                                }
                              },
                            ),
                            CustomButton(
                              text: 'Delete',
                              onPressed: () {
                                final authBloc =
                                    BlocProvider.of<AuthBloc>(context);
                                if (_formKey.currentState!.validate()) {
                                  authBloc.add(DeleteConfirmEvent());
                                }
                              },
                              color: const Color.fromARGB(255, 170, 181, 135),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
