import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TicketBox extends StatelessWidget {
   TicketBox({
    super.key,
    this.onTap,
    required this.event,
    required this.bookid,
    required this.image,
    required this.booktime,
    this.count=0,
  });
  final void Function()? onTap;
  final String event;
  final String bookid;
  final String image;
  final String booktime;
  int count;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        width: MediaQuery.of(context).size.width*90,
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(255, 68, 73, 53), width: 1.5),
          borderRadius: const BorderRadius.all(
            Radius.elliptical(10, 15),
          ),
        ),

        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  event,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 22),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  'BOOKING ID : $bookid'.toString().split('-')[0],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  booktime,
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
