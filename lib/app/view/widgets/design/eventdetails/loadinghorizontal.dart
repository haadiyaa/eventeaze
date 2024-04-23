
import 'package:flutter/material.dart';

class LoadinHorizontalcard extends StatelessWidget {
  const LoadinHorizontalcard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 155,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child:const ClipRRect(
                  borderRadius:  BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
