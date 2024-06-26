import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:eventeaze/app/model/usermodel.dart';
import 'package:eventeaze/app/serivices/notificationservices.dart';
import 'package:eventeaze/app/view/common/design/mycircle2.dart';
import 'package:eventeaze/app/view/screens/authentication/login/page/login_page.dart';
import 'package:eventeaze/app/view/common/buttons/custombutton.dart';
import 'package:eventeaze/app/view/screens/authentication/widgets/customtextfield.dart';
import 'package:eventeaze/app/view/screens/authentication/widgets/googlewidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignUpPageWrapper extends StatelessWidget {
  const SignUpPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: SignUpPage(),
    );
  }
}

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  NotificationServices notificationServices = NotificationServices();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
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
        } else if (state is AuthenticatedState) {
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(10),
              content: Text('Successfully Signed Up!'),
              backgroundColor: Color.fromARGB(255, 89, 121, 90),
            ),
          );
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const LoginPageWrapper()));
        }
        if (state is UnAuthenticatedState) {
          Navigator.pop(context);
        }
        if (state is AuthenticatedErrorState) {
          Navigator.pop(context);
          if (state.message.contains('network-request-failed')) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(10),
                content: Text('Please check your internet connection'),
              ),
            );
          } else if (state.message.contains('email-already-in-use')) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(10),
                content: Text(
                    'The account already exists with a different credential'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(10),
                content: Text(state.message),
              ),
            );
          }

          print(state.message);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const MyCircle2(),
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
                      'Create Account',
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
                      'Sign up now for access to the hottest events in town. It\'s quick, easy, and free!',
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
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                  RegExp(r'\s{2,}')),
                              LengthLimitingTextInputFormatter(25)
                            ],
                            keyboardType: TextInputType.name,
                            autovalidateMode: autovalidateMode,
                            controller: _nameController,
                            labelText: 'User Name',
                            validator: (value) {
                              final name = RegExp(r'^[A-Za-z\s]{3,}[\s]*$');
                              if (value!.isEmpty) {
                                return 'User name can\'t be empty';
                              } else if (!name.hasMatch(value)) {
                                return "Enter a valid name";
                              }
                            },
                          ),
                          CustomTextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                              LengthLimitingTextInputFormatter(10)
                            ],
                            keyboardType: TextInputType.phone,
                            autovalidateMode: autovalidateMode,
                            controller: _phoneController,
                            labelText: 'Phone Number',
                            validator: (value) {
                              final reg2 = RegExp(r"^[6789]\d{9}[\s]*$");
                              if (value!.isEmpty) {
                                return 'Number can\'t be empty';
                              } else if (value.trim().length > 10) {
                                return "number exact 10";
                              } else if (!reg2.hasMatch(value)) {
                                return 'Enter a valid phone number';
                              }
                            },
                          ),
                          CustomTextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                              LengthLimitingTextInputFormatter(40)
                            ],
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode: autovalidateMode,
                            controller: _emailController,
                            labelText: 'Email Address',
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
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                              LengthLimitingTextInputFormatter(15)
                            ],
                            keyboardType: TextInputType.visiblePassword,
                            autovalidateMode: autovalidateMode,
                            obscuretext: true,
                            controller: _passwordController,
                            labelText: 'Enter Password',
                            validator: (value) {
                              final paswd = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                              if (value!.isEmpty) {
                                return 'please enter the password';
                              } else if (!paswd.hasMatch(value)) {
                                return 'Password should contain at least one upper case, one lower case, one digit, one special character and must be 8 characters in length';
                              }
                            },
                          ),
                          CustomButton(
                            text: 'Sign Up',
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              autovalidateMode =
                                  AutovalidateMode.onUserInteraction;
                              if (_formKey.currentState!.validate()) {
                                notificationServices
                                    .getDeviceToken()
                                    .then((value) {
                                  UserModel user = UserModel(
                                    token: value,
                                    username: _nameController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    email: _emailController.text.trim(),
                                    phone: _phoneController.text.trim(),
                                  );
                                  authBloc.add(SignUpEvent(user: user));
                                });
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'Or Sign In with',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(200, 73, 78, 58)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GoogleWidget(),
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
                    'Already have an account? ',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginPageWrapper()));
                    },
                    child: const Text(
                      'Login',
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
      ),
    );
  }
}
