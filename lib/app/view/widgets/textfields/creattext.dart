import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateText extends StatelessWidget {
  const CreateText({
    super.key,
    required this.text,
    required this.controller,
    this.validator,
    this.maxLines, this.keyboardType, this.onTap, this.hintText ,
  });
  final String text;
  final String? hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextInputType? keyboardType;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s{2,}'))
        ],
        onTap: onTap,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          label: Text(text),
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 81, 87, 64),
          ),
          filled: true,
          fillColor:const Color.fromARGB(170, 243, 242, 242),
          border: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 170, 181, 135)),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 170, 181, 135), width: 0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 170, 181, 135)),
            borderRadius: BorderRadius.circular(15),
          ),
          errorStyle: const TextStyle(fontSize: 10),
          errorBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 170, 181, 135)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
