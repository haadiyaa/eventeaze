import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/view/screens/eventdetailspage/page/eventdetailspage.dart';
import 'package:eventeaze/app/view/screens/profilescreen/page/usereventdetailspage.dart';
import 'package:eventeaze/app/view/common/design/eventdetails/eventverticalcard.dart';
import 'package:eventeaze/app/view/common/shimmers/shimmerrecommended.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RecommendedList extends StatefulWidget {
  const RecommendedList({
    super.key,
  });

  @override
  State<RecommendedList> createState() => _RecommendedListState();
}

class _RecommendedListState extends State<RecommendedList> {
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
          .orderBy('seats')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SizedBox(
              height: 150,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                itemCount: 7,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final event = snapshot.data!.docs[index].data();
                  return EventVerticalCard(
                    image: event['image'],
                    title: event['eventName'],
                    onTap: () {
                      if(event['id']==user!.uid){
                                
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          UserEventDetailsWrapper(id: event['eventId'],)));
                              }else{
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          EventDetailsPage(id: event['eventId'],)));
                              };
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
