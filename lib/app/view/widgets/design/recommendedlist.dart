import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/view/screens/eventdetailspage.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/eventverticalcard.dart';
import 'package:eventeaze/app/view/widgets/shimmers/shimmerrecommended.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecommendedList extends StatelessWidget {
  const RecommendedList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('events')
          .orderBy('seats')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SizedBox(
              height: 150,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final event = snapshot.data!.docs[index].data();
                  return EventVerticalCard(
                    image: event['image'],
                    title: event['eventName'],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  EventDetailsPage(id: event['eventId'])));
                    },
                  );
                },
              ),
            ),
          );
        }
        if (snapshot.connectionState==ConnectionState.waiting) {
          return const ShimmerRecommendedList();
        }
        return const ShimmerRecommendedList();
      },
    );
  }
}
