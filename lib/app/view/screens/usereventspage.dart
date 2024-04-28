import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/view/screens/createeventpage.dart';
import 'package:eventeaze/app/view/screens/eventdetailspage.dart';
import 'package:eventeaze/app/view/screens/usereventdetailspage.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/eventhorizontalcard.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/loadinghorizontal.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/usereventcard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserEventsPage extends StatefulWidget {
  UserEventsPage({super.key});

  @override
  State<UserEventsPage> createState() => _UserEventsPageState();
}

class _UserEventsPageState extends State<UserEventsPage> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Events',
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
              .where('id', isEqualTo: user!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text('Sorry! Something went Wrong!'),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'You Have not Created any Events yet!\n Create your First Event!',
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CreateEventWrapper(),
                          ),
                        );
                      },
                      label: const Text('Create'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 233, 237, 201),
                        foregroundColor: const Color.fromARGB(255, 68, 73, 53),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
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
                          return UserEventCard(
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => UserEventDetailsWrapper(
                                            id: eventdata['eventId'],
                                          )));
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),  
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        return LoadinHorizontalcard();
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
