import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/view/screens/eventdetailspage.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/eventhorizontalcard.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/loadinghorizontal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpcomingList extends StatelessWidget {
  UpcomingList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('events')
            .where('eventDate',isGreaterThan: DateTime.now())
            .orderBy('eventDate')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('Data: ${snapshot.data!.docs}');

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
                        date: DateFormat('yyyy-MM-dd').format(eventdata['eventDate'].toDate()).split('-').reversed.join('-'),
                        time: eventdata['eventTime'],
                        location: eventdata['location'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EventDetailsPage(
                                id: eventdata['eventId'],
                              ),
                            ),
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
                    return const LoadinHorizontalcard();
                  },
                ),
              ],
            ),
          );
        });
  }
}
