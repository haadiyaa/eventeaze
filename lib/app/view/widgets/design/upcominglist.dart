import 'package:eventeaze/app/view/widgets/design/eventhorizontalcard.dart';
import 'package:flutter/material.dart';

class UpcomingList extends StatelessWidget {
  const UpcomingList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
      child: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return EventHorizontalCard();
            },
          ),
        ],
      ),
    );
  }
}
