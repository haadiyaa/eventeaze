import 'package:flutter/material.dart';


class MyCircle2 extends StatelessWidget {
  const MyCircle2({
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
            top: -90,
            right: 80,
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
            top: -70,
            right: -40,
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
              height: 110,
              width: 170,
            ),
        ],
      ),
    );
  }
}