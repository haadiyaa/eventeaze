
import 'package:flutter/material.dart';

class AboutEventData extends StatelessWidget {
  const AboutEventData({super.key, required this.desc, required this.title});

  final String desc, title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(200, 68, 73, 53),
                fontSize: 16),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            desc,
            style: const TextStyle(
              color: Color.fromARGB(225, 68, 73, 53),
            ),
          ),
        ],
      ),
    );
  }
}
