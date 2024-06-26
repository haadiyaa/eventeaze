import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 93, 99, 99).withOpacity(0.2),
              blurRadius: 7,
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
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: SvgPicture.asset(
                'assets/search-normal.svg',
              ),
            ),
            const Text(
              'Search',
              style: TextStyle(
                color: Color.fromARGB(255, 147, 156, 118),
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
