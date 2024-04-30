import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 68, 73, 53),
            fontSize: 24,
          ),
        ),
      ),
      body:const Column(
        children: [

        ],
      ),
    );
  }
}
