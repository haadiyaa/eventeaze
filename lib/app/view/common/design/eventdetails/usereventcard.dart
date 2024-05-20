import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class UserEventCard extends StatelessWidget {
  const UserEventCard({
    super.key,
    this.onTap,
    required this.image,
    required this.title,
    required this.date,
    required this.location, required this.time,
  });
  final void Function()? onTap;
  final String image;
  final String title;
  final String date;
  final String time;
  final String location;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Stack(
          children: [
            Container(
              height: 155,
              clipBehavior: Clip.antiAlias,
              width: MediaQuery.of(context).size.width*0.9,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                height: 70,
                width: MediaQuery.of(context).size.width*0.9,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(159, 138, 137, 137),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          children: [
                             Text(
                              date,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                            SvgPicture.asset('assets/Calendar.svg'),
                          ],
                        ),
                      ],
                    ),
                     Row(
                      children: [
                        Text(
                          time,
                          style:const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                     Row(
                      children: [
                        Text(
                          location,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
