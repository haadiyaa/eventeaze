import 'package:eventeaze/app/bloc/functionBloc/functions_bloc.dart';
import 'package:eventeaze/app/model/categorymodel.dart';
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
            if (state is FetchCategoryState) {
              allCategory = state.list;
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
                      itemCount: len,
                      itemBuilder: (BuildContext context, int index) {
                        if (allCategory != null) {
                          final catLis = allCategory!;
                          return CategoryCard(
                            image: catLis[index].image,
                            text: catLis[index].name,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>EventList(title: catLis[index].name)));
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
