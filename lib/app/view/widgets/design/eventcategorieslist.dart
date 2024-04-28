import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/view/screens/categorylist.dart';
import 'package:eventeaze/app/view/widgets/buttons/verticalimagetext.dart';
import 'package:eventeaze/app/view/widgets/shimmers/shimmerloadingcategorycard.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EventCategories extends StatelessWidget {
  EventCategories({
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
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child:  Container(
                          color: Colors.white,
                          height: 10,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        if (snapshot.hasData) {
          return SizedBox(
            height: 165,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final category = snapshot.data!.docs[index].data();

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
              },
            ),
          );
        }
        return const ShimmerLoadingCategoryCard();
      },
    );
  }
}
