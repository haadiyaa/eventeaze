import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:eventeaze/app/view/screens/forgotpass_page.dart';
import 'package:eventeaze/app/view/screens/homepage.dart';
import 'package:eventeaze/app/view/screens/signuppage.dart';
import 'package:eventeaze/app/view/screens/splashscreen.dart';
import 'package:eventeaze/app/view/screens/tabs_screen.dart';
import 'package:eventeaze/app/view/widgets/buttons/custombutton.dart';
import 'package:eventeaze/app/view/widgets/textfields/customtextfield.dart';
import 'package:eventeaze/app/view/widgets/design/mycircle.dart';
import 'package:eventeaze/app/view/widgets/googlewidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageWrapper extends StatelessWidget {
  const LoginPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(10),
              content: Text('Successfully Logged In!'),
              backgroundColor: Color.fromARGB(255, 89, 121, 90),
            ),
          );
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const TabsScreenWrapper()));
          });
        } else if (state is AuthenticatedErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(10),
              content: Text(
                  'No User Found with this email or password did not match'),
            ),
          );
        } else if (state is UnAuthenticatedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(10),
              content: Text('No User Found '),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const MyCircle(),
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
                        'Welcome back!',
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
                        'Unlock a world of events with EventEaze. Log in to discover and attend a variety of exciting events tailored to your interests, all in one place.',
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
                              hintText: 'Email Address',
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
                            // const SizedBox(height: 10,),
                            CustomTextField(
                              controller: _passwordController,
                              hintText: 'Enter Password',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const ForgotPassWrapper()));
                                  },
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Color.fromARGB(255, 68, 73, 53)),
                                  ),
                                ),
                              ],
                            ),
                            CustomButton(
                              text: 'Login',
                              onPressed: () async {
                                final authBloc =
                                    BlocProvider.of<AuthBloc>(context);
                                if (_formKey.currentState!.validate()) {
                                  
                                  authBloc.add(LoginEvent(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim()));
                                }
                              },
                              color: const Color.fromARGB(255, 170, 181, 135),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Or Sign In with',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Color.fromARGB(200, 73, 78, 58)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: const GoogleWidget(),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  indent: 20,
                  endIndent: 20,
                  color: Colors.black,
                  thickness: 0.5,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account? ',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SignUpPageWrapper()));
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
