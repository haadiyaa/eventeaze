
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyBanner extends StatelessWidget {
  const MyBanner({
    super.key, this.onTap,
  });
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Banner(
        message: 'Free',
        location: BannerLocation.topEnd,
        child: Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:
                  const Color.fromARGB(255, 242, 247, 231),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(3, 3),
                  blurRadius: 10,
                ),
              ]),
          child: Row(
            children: [
              LottieBuilder.asset(
                  'assets/lottie/Animation - 1715253108377.json'),
              const SizedBox(
                width: 10,
              ),
              const Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Discover\nExciting\nFree\nEvents!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color:
                          Color.fromARGB(255, 68, 73, 53),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
