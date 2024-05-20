import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/view/screens/categoriesscreen/page/categorylist.dart';
import 'package:eventeaze/app/view/screens/homescreen/widgets/verticalimagetext.dart';
import 'package:eventeaze/app/view/common/shimmers/shimmerloadingcategorycard.dart';
import 'package:eventeaze/app/view/common/shimmers/shimmerverticlacard.dart';
import 'package:flutter/material.dart';

class EventCategories extends StatelessWidget {
  const EventCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('categories').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 165,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return const ShimmerVerticalCard();
              },
            ),
          );
        }
        if (snapshot.hasData) {
          return SizedBox(
            height: 165,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shrinkWrap: true,
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final category = snapshot.data?.docs[index].data();
                if (category != null) {
                  return VerticalImageText(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  CategoryList(title: category['name'])));
                    },
                    text: category['name'],
                    image: category['image'],
                  );
                }
              },
            ),
          );
        }
        return const ShimmerLoadingCategoryCard();
      },
    );
  }
}
