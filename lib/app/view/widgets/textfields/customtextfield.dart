import 'package:eventeaze/app/bloc/cubit/password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    // required this.hintText,
    this.validator,
    required this.labelText,
    this.keyboardType,
    this.obscuretext = false,
  });
  final TextEditingController controller;
  // final String hintText;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscuretext;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordCubit(),
      child: BlocBuilder<PasswordCubit, bool>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 93, 99, 99).withOpacity(0.2),
                  blurRadius: 7,
                  offset: const Offset(0, 5),
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: BlocBuilder<PasswordCubit, bool>(
              builder: (context, isPasswordVisible) {
                return TextFormField(
                  obscureText: obscuretext&& !isPasswordVisible,
                  keyboardType: keyboardType ?? TextInputType.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller,
                  validator: validator,
                  decoration: InputDecoration(
                    suffixIcon: obscuretext
                        ? IconButton(
                            onPressed: () {
                              context.read<PasswordCubit>().toggleVisibilty();
                            },
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          )
                        : null,
                    // hintText: hintText,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    labelText: labelText,
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 170, 181, 135)),
                    // hintStyle:
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorStyle: const TextStyle(fontSize: 10),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
