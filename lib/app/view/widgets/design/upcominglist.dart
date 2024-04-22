import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/view/screens/eventdetailspage.dart';
import 'package:eventeaze/app/view/widgets/design/eventhorizontalcard.dart';
import 'package:eventeaze/app/view/widgets/design/loadinghorizontal.dart';
import 'package:flutter/material.dart';

class UpcomingList extends StatelessWidget {
  const UpcomingList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('events')
            .orderBy('eventDate')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final eventdata = snapshot.data!.docs[index].data();
                      return EventHorizontalCard(
                        image: eventdata['image'],
                        title: eventdata['eventName'],
                        date: eventdata['eventDate'],
                        time: eventdata['eventTime'],
                        location: eventdata['location'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const EventDetailsPage()),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return LoadinHorizontalcard();
                    },
                  ),
                ],
              ),
            );
        });
  }
}
