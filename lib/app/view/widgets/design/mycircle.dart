import 'package:flutter/material.dart';


class MyCircle extends StatelessWidget {
  const MyCircle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Positioned(
            top: -70,
            left: 10,
            child: Container(
              height: 170,
              width: 170,
              decoration:const  BoxDecoration(
                color: Color.fromARGB(255, 233, 237, 201),
                shape: BoxShape.circle
              ),
            ),
          ),
          Positioned(
            top: -50,
            left: -40,
            child: Container(
              height: 170,
              width: 170,
              decoration:const  BoxDecoration(
                color: Color.fromARGB(255, 170, 181, 135),
                shape: BoxShape.circle
              ),
            ),
          ),
          const SizedBox(
              height: 140,
              width: 170,
            ),
        ],
      ),
    );
  }
}