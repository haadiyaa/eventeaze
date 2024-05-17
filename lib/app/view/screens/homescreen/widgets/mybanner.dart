
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

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
        child: FittedBox(
          fit: BoxFit.cover,
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
                 Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 51, 54, 39),
                      highlightColor: const Color.fromARGB(255, 113, 121, 89),
                      child: const Text(
                        'Discover\nExciting\nFree\nEvents!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color:
                              Color.fromARGB(255, 68, 73, 53),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
