import 'package:flutter/material.dart';

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    super.key,
    required this.title,
    required this.desc,
  });
  final String title, desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
                color: Color.fromARGB(255, 68, 73, 53),
                fontWeight: FontWeight.bold,
                fontSize: 24),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            desc,
            style: const TextStyle(
                color: Color.fromARGB(255, 68, 73, 53),
                fontWeight: FontWeight.normal,
                fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
