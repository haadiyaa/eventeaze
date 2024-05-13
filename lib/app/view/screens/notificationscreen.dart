import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({
    super.key,
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 68, 73, 53),
            fontSize: 24,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(
                Icons.notifications,
                color: Color.fromARGB(255, 68, 73, 53),
              ),
              title: Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              subtitle: Text(
                body,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,style: const TextStyle(fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
