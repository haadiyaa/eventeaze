
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingCategoryCard extends StatelessWidget {
  const ShimmerLoadingCategoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SizedBox(
        height: 165,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
