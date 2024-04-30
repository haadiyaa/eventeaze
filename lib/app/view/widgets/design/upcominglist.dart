import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/view/screens/eventdetailspage.dart';
import 'package:eventeaze/app/view/screens/usereventdetailspage.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/eventhorizontalcard.dart';
import 'package:eventeaze/app/view/widgets/shimmers/shimmerupcoming.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpcomingList extends StatefulWidget {
  UpcomingList({
    super.key,
  });

  @override
  State<UpcomingList> createState() => _UpcomingListState();
}

class _UpcomingListState extends State<UpcomingList> {
  User? user;

   @override
   void initState() {
     super.initState();
     user=FirebaseAuth.instance.currentUser;
   }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('events')
            .where('eventDate', isGreaterThan: DateTime.now())
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
                        date: DateFormat('yyyy-MM-dd')
                            .format(eventdata['eventDate'].toDate())
                            .split('-')
                            .reversed
                            .join('-'),
                        time: eventdata['eventTime'],
                        location: eventdata['location'],
                        onTap: () {
                          if(eventdata['id']==user!.uid){
                                
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          UserEventDetailsWrapper(id: eventdata['eventId'],)));
                              }else{
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          EventDetailsPage(id: eventdata['eventId'],)));
                              }
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return const ShimmerUpcoming();
        });
  }
}
