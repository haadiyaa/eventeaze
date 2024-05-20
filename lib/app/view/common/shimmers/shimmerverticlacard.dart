
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerVerticalCard extends StatelessWidget {
  const ShimmerVerticalCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Column(
        children: [
          Shimmer.fromColors(
            loop: 1,
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child:  Container(
              color: Colors.white,
              height: 10,
            ),
          ),
        ],
      ),
    );
  }
}
