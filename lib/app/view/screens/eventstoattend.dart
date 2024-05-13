import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/bottomsheet.dart';
import 'package:eventeaze/app/view/widgets/design/ticketbox.dart';
import 'package:eventeaze/app/view/widgets/shimmers/shimmerupcoming.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsToAttend extends StatefulWidget {
  EventsToAttend({super.key});

  @override
  State<EventsToAttend> createState() => _EventsToAttendState();
}

class _EventsToAttendState extends State<EventsToAttend> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Events To Attend',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 68, 73, 53),
            fontSize: 24,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser!.uid)
              .collection('myevents')
              .where('eventDate', isGreaterThan: DateTime.now())
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final eventdata = snapshot.data!.docs[index].data();
                    return TicketBox(
                      onTap: () {
                        showModalBottomSheet(
                          showDragHandle: true,
                          context: context,
                          builder: (context) {
                            return MyBottomSheet(eventdata: eventdata);
                          },
                        );
                      },
                      booktime: DateFormat("dd MMM yyyy 'at' hh:mm a")
                          .format(eventdata['bookingTime'].toDate()),
                      image: eventdata['image'],
                      event: eventdata['eventName'],
                      bookid: eventdata['eventId'],
                    );
                  },
                ),
              );
            }
            return const ShimmerUpcoming();
          }),
    );
  }
}
