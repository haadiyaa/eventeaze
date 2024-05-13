import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserNotificationsPage extends StatefulWidget {
  UserNotificationsPage({super.key});

  @override
  State<UserNotificationsPage> createState() => _UserNotificationsPageState();
}

class _UserNotificationsPageState extends State<UserNotificationsPage> {
  User? _currentUser;
  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
  }

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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(_currentUser!.uid)
              .collection('notifications')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final notification = snapshot.data!.docs[index].data();
                    return ListTile(
                      leading:const Icon(
                        Icons.notifications,
                        color: Color.fromARGB(255, 68, 73, 53),
                      ),
                      title: Text(
                        notification['title'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      subtitle: Text(
                        notification['body'],
                        style: const TextStyle(fontWeight: FontWeight.w300),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No notifications!'),
              );
            }
            return const Center();
          }),
    );
  }
}
