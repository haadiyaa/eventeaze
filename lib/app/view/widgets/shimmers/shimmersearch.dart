
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSearch extends StatelessWidget {
  const ShimmerSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: ListView(
        children: [
          Shimmer.fromColors(
            baseColor:const Color.fromARGB(255, 228, 228, 228),
            highlightColor: const Color.fromARGB(255, 231, 231, 231),
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(height: 5,),
          Shimmer.fromColors(
            baseColor:Color.fromARGB(255, 228, 228, 228),
            highlightColor: Color.fromARGB(255, 231, 231, 231),
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 5,),
          Shimmer.fromColors(
            baseColor:const Color.fromARGB(255, 228, 228, 228),
            highlightColor: const Color.fromARGB(255, 231, 231, 231),
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10)),
            ),
          )
        ],
      ),
    );
  }
}
