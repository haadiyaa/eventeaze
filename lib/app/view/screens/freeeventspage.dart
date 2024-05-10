import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/view/screens/eventdetailspage.dart';
import 'package:eventeaze/app/view/screens/usereventdetailspage.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/eventhorizontalcard.dart';
import 'package:eventeaze/app/view/widgets/shimmers/shimmerupcoming.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FreeEventsPage extends StatefulWidget {
  const FreeEventsPage({super.key});

  @override
  State<FreeEventsPage> createState() => _FreeEventsPageState();
}

class _FreeEventsPageState extends State<FreeEventsPage> {
  User? user;

  @override
  void initState() {
    super.initState();
    user=FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Free Events',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 68, 73, 53),
            fontSize: 24,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('events')
              .where('freeOrPaid',isEqualTo: 'Free')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    'Oops!\nThis Category is Empty!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: SingleChildScrollView(
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
                ),
              );
            }
            return const ShimmerUpcoming();
          }),
    );
  }
}
