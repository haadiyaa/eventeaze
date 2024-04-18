import 'package:flutter/material.dart';

class EventHorizontalCard extends StatelessWidget {
  const EventHorizontalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          Container(
            height: 155,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20),
              ),
              child: Image(
                image: AssetImage('assets/events/arts.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 70,
              width:350,
              decoration: const BoxDecoration(
                color: Color.fromARGB(159, 138, 137, 137),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
