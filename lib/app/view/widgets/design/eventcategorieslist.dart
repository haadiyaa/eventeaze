import 'package:eventeaze/app/view/widgets/buttons/verticalimagetext.dart';
import 'package:flutter/material.dart';

class EventCategories extends StatelessWidget {
  const EventCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 165,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return VerticalImageText(
            onTap: () {},
            text: 'Music & Concerts',
            image: 'assets/categories/music.jpg',
          );
        },
      ),
    );
  }
}
