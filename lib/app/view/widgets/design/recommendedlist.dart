import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/eventverticalcard.dart';
import 'package:flutter/material.dart';

class RecommendedList extends StatelessWidget {
  const RecommendedList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('events').snapshots(),
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
                    onTap: () {},
                  );
                },
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SizedBox(
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
