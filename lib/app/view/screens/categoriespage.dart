import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/bloc/functionBloc/functions_bloc.dart';
import 'package:eventeaze/app/model/categorymodel.dart';
import 'package:eventeaze/app/view/screens/categorylist.dart';
import 'package:eventeaze/app/view/screens/eventlist.dart';
import 'package:eventeaze/app/view/widgets/design/categorycard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({super.key});

  List<CategoryModel>? allCategory;
  int? len = 5;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FunctionsBloc()..add(FetchCategoryEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Categories',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 68, 73, 53),
              fontSize: 24,
            ),
          ),
        ),
        body: BlocBuilder<FunctionsBloc, FunctionsState>(
          builder: (context, state) {
            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('categories')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 195,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 15,
                              ),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                final category =
                                    snapshot.data!.docs[index].data();

                                return CategoryCard(
                                  image: category['image'],
                                  text: category['name'],
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => CategoryList(
                                                title: category['name'])));
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 195,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                            ),
                            itemCount: 6,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: 170,
                                height: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
