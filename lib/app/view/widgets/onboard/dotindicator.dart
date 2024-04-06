import 'package:flutter/material.dart';


class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 5,
      width: isActive ? 25 : 5,
      decoration: BoxDecoration(
          color:isActive? Color.fromARGB(255, 139, 134, 136):Color.fromARGB(255, 206, 203, 204),
          borderRadius: BorderRadius.all(Radius.circular(50))),
    );
  }
}
