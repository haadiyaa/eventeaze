import 'package:flutter/material.dart';


class IconBox extends StatelessWidget {
  const IconBox({
    super.key, required this.icon,
  });
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.12,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 7,
            offset: Offset(0, 4),
            color: Colors.grey,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 233, 237, 201),
      ),
      child: Icon(
        icon,
        size: 35,
        color: Color.fromARGB(255, 68, 73, 53),
      ),
    );
  }
}