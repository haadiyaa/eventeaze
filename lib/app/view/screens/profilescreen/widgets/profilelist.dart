import 'package:eventeaze/app/view/screens/profilescreen/page/eventstoattend.dart';
import 'package:eventeaze/app/view/screens/profilescreen/page/privacypolicy.dart';
import 'package:eventeaze/app/view/screens/profilescreen/page/usereventspage.dart';
import 'package:flutter/material.dart';


class ProfileList extends StatelessWidget {
  const ProfileList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>UserEventsPage()));
            },
            child: const ListTile(
              title: Text(
                'MY EVENTS',
                style: TextStyle(
                  color: Color.fromARGB(255, 68, 73, 53),
                ),
              ),
              trailing: Icon(
                Icons.arrow_circle_right_outlined,
                color: Color.fromARGB(255, 68, 73, 53),
              ),
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>EventsToAttend()));
            },
            child: const ListTile(
              title: Text(
                'EVENTS TO ATTEND',
                style: TextStyle(
                  color: Color.fromARGB(255, 68, 73, 53),
                ),
              ),
              trailing: Icon(
                Icons.arrow_circle_right_outlined,
                color: Color.fromARGB(255, 68, 73, 53),
              ),
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>const PrivacyPolicy()));
            },
            child: const ListTile(
              title: Text(
                'PRIVACY POLICY',
                style: TextStyle(
                  color: Color.fromARGB(255, 68, 73, 53),
                ),
              ),
              trailing: Icon(
                Icons.arrow_circle_right_outlined,
                color: Color.fromARGB(255, 68, 73, 53),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
