import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/bloc/functionBloc/functions_bloc.dart';
import 'package:eventeaze/app/model/categorymodel.dart';
import 'package:eventeaze/app/view/screens/categorylist.dart';
import 'package:eventeaze/app/view/widgets/buttons/verticalimagetext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventCategories extends StatelessWidget {
  EventCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FunctionsBloc, FunctionsState>(
      builder: (context, state) {
        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream:
                FirebaseFirestore.instance.collection('categories').snapshots(),
            builder: (context, snapshot) {
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
              return SizedBox(
                height: 165,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  },
                ),
              );
            });
      },
    );
  }
}
