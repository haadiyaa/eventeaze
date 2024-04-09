import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:eventeaze/app/view/widgets/buttons/custombutton.dart';
import 'package:eventeaze/app/view/widgets/textfields/customtextfield.dart';
import 'package:eventeaze/app/view/widgets/design/customalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPassWrapper extends StatelessWidget {
  const ForgotPassWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: ForgotPassPage(),
    );
  }
}

class ForgotPassPage extends StatelessWidget {
  ForgotPassPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ForgotPassState) {
          showDialog(
            context: context,
            builder: (context) {
              return const CustomAlert();
            },
          );
        }
        if (state is PasswordResetErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'No User Found with this email'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 233, 237, 201),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Forgot your Password?',
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
                        'No worries! Enter your email address below and we\'ll send you a link to reset your password.',
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
                            CustomButton(
                              text: 'Send link',
                              onPressed: () {
                                final authBloc =
                                    BlocProvider.of<AuthBloc>(context);
                                if (_formKey.currentState!.validate()) {
                                  authBloc.add(ForgotPassEvent(
                                      email: _emailController.text.trim()));
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
