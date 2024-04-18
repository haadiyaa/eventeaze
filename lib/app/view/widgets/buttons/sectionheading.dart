import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    this.buttonTitle='see all',
    this.onPressed,
    this.showActionButton=true,
  });
  final String title;
  final String buttonTitle;
  final void Function()? onPressed;
  final bool showActionButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color.fromARGB(255, 68, 73, 53),
            fontSize: 21,
            fontWeight: FontWeight.w900,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(
            onPressed: onPressed,
            child: Text(
              buttonTitle,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: Color.fromARGB(255, 68, 73, 53),
              ),
            ),
          ),
      ],
    );
  }
}
