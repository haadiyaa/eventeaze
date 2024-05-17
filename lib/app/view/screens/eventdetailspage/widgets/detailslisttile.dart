import 'package:eventeaze/app/view/widgets/design/eventdetails/detailscard.dart';
import 'package:flutter/material.dart';


class DetailsListTile extends StatelessWidget {
  const DetailsListTile({
    super.key, required this.title, required this.subtitle, required this.icon,
  });
  final String title,subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconBox(icon: icon),
      title: Text(
        title,
        style: const TextStyle(
          color: Color.fromARGB(255, 68, 73, 53),
          fontSize: 18,
        ),
      ),
      subtitle: Text(
              subtitle,
              style: const TextStyle(
                color: Color.fromARGB(255, 68, 73, 53),
                fontSize: 10,
              ),
            ),
    );
  }
}
