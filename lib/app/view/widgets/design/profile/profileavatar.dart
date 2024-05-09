import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  ProfileAvatar({super.key, this.child});

  Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 70,
      width: 70,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 184, 197, 146),
        // border: Border.all(color: const Color.fromARGB(255, 68, 73, 53)),
        boxShadow: [
          BoxShadow(blurRadius: 7, offset: Offset(0, 4), color: Colors.grey),
        ],
      ),
      child: child ?? const Icon(Icons.person),
    );
  }
}
