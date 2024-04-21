import 'package:eventeaze/app/bloc/functionBloc/functions_bloc.dart';
import 'package:eventeaze/app/model/categorymodel.dart';
import 'package:eventeaze/app/view/widgets/buttons/verticalimagetext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventCategories extends StatelessWidget {
  EventCategories({
    super.key,
    required this.list,
  });
  final List<CategoryModel>? list;
  int? len = 5;

  @override
  Widget build(BuildContext context) {
    if (list != null) {
      len = list!.length;
    }
    return BlocBuilder<FunctionsBloc, FunctionsState>(
      builder: (context, state) {
        return SizedBox(
          height: 165,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: len,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              if (list != null) {
                final catList = list!;
                return VerticalImageText(
                  onTap: () {},
                  text: catList[index].name,
                  image: catList[index].image,
                );
              }
            },
          ),
        );
      },
    );
  }
}
