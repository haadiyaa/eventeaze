import 'package:eventeaze/app/view/widgets/design/eventverticalcard.dart';
import 'package:flutter/material.dart';

class RecommendedList extends StatelessWidget {
  const RecommendedList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SizedBox(
        height: 150,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return EventVerticalCard(
            image: 'assets/categories/music.jpg',
            title: 'Arts & Culture',
            onTap: () {},
          );
          },
        ),
      ),
    );
  }
}
