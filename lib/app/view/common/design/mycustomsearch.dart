import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyCustomSearchBar extends StatelessWidget {
  const MyCustomSearchBar({
    super.key,
    this.onChange,
  });
  final void Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 11, 12, 12).withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 5),
            )
          ],
          color: const Color.fromARGB(255, 245, 243, 243),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(
            color: const Color.fromARGB(150, 194, 194, 194),
            width: 0.25,
          ),
        ),
        child: TextField(
          autofocus: true,
          onChanged: onChange,
          decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: SvgPicture.asset(
                  'assets/search-normal.svg',
                ),
              ),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: EdgeInsets.all(0)),
        ),
      ),
    );
  }
}
