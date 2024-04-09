import 'package:flutter/material.dart';

class UpdateTextField extends StatelessWidget {
  const UpdateTextField({
    super.key,
    required this.controller,
    required this.text,
    this.enabled,
  });

  final TextEditingController controller;
  final String text;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        enabled: enabled ?? true,
        style: const TextStyle(
          color: Color.fromARGB(255, 68, 73, 53),
          fontSize: 18,
        ),
        controller: controller,
        decoration: InputDecoration(
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 68, 73, 53),
                width: 0.25,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(68, 73, 53, 1),
                width: 0.25,
              ),
            ),
            disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(68, 73, 53, 1),
                width: 0.25,
              ),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 68, 73, 53),
                width: 0.25,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 68, 73, 53),
                width: 1.5,
              ),
            ),
            labelStyle: const TextStyle(
                color: Color.fromARGB(150, 68, 73, 53),
                fontWeight: FontWeight.w500),
            labelText: text,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8)),
      ),
    );
  }
}
