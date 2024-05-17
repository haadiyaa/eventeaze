import 'package:flutter/material.dart';

class AboutEvent extends StatelessWidget {
  const AboutEvent({super.key, required this.desc, required this.title});

  final String desc,title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(200, 68, 73, 53),
              fontSize: 16),
        ),
        const SizedBox(height: 8,),
        Text(
          desc,
          style: const TextStyle(
            color: Color.fromARGB(225, 68, 73, 53),
          ),
        ),
      ],
    );
  }
}
