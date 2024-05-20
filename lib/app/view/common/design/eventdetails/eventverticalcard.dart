import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class EventVerticalCard extends StatelessWidget {
  const EventVerticalCard({
    super.key,
    this.onTap,
    required this.image,
    required this.title,
  });
  final void Function()? onTap;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 5,left: 5),
        child: Stack(
          children: [
            Container(
              width: 150,
              height: 150,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 10,
                    height: 10,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                height: 65,
                width: 150,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(159, 110, 110, 110),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
