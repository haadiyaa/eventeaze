import 'package:flutter/material.dart';


class GoogleWidget extends StatelessWidget {
  const GoogleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 233, 237, 201),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 90, 94, 94)
                .withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Image(
        image: AssetImage(
          'assets/google2.png',
        ),
        width: 30,
        height: 30,
      ),
    );
  }
}
