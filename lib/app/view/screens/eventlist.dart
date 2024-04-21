import 'package:eventeaze/app/view/screens/eventdetailspage.dart';
import 'package:eventeaze/app/view/widgets/design/eventhorizontalcard.dart';
import 'package:flutter/material.dart';

class EventList extends StatelessWidget {
  const EventList({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 68, 73, 53),
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return EventHorizontalCard(
                    image: 'assets/events/arts.jpg',
                    title: 'Arts & Culture',
                    date: '01, March 2024',
                    time: '2 PM -5 PM',
                    location: 'Mumbai',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const EventDetailsPage()));
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
