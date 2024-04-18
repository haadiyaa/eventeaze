import 'package:flutter/material.dart';

class CreateText extends StatelessWidget {
  const CreateText({
    super.key,
    required this.text,
    required this.controller,
  });
  final String text;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          hintStyle:const  TextStyle(
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 170, 181, 135),
          ),
          filled: true,
          fillColor: const Color.fromARGB(99, 219, 219, 219),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          errorStyle: const TextStyle(fontSize: 10),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
