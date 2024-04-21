import 'package:eventeaze/app/view/widgets/buttons/custombutton.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/aboutevent.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/detailslisttile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor:const Color.fromARGB(255, 105, 114, 77),
            leading: const BackButton(
              color: Colors.white,
            ),
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/events/arts.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black12,
                        Colors.black87,
                      ],
                    ),
                  ),
                ),
              ),
              title: const Text('Arts & Culture'),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DetailsListTile(
                    title: '01, March 2024',
                    subtitle: '2 PM to 5 PM',
                    icon: Icons.calendar_month_outlined,
                  ),
                  const DetailsListTile(
                    title: 'Mumbai',
                    subtitle: 'Jehangir Art Gallery',
                    icon: Icons.location_on_outlined,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //description

                  const AboutEvent(
                    title: 'ABOUT EVENT',
                    desc:
                        'This dynamic event celebrates the rich diversity of arts and culture from around the globe, bringing together artists, performers, and cultural enthusiasts for a vibrant and immersive experience.',
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //tickets
                  const AboutEvent(desc: '800', title: 'AVAILABLE SEATS'),
                  const SizedBox(
                    height: 10,
                  ),
                  //ticket price
                  const AboutEvent(desc: '1000 INR', title: 'TICKET PRICE'),
                  const SizedBox(
                    height: 20,
                  ),

                  //contact

                  const AboutEvent(desc: '8907643349', title: 'CONTACT'),
                  const SizedBox(
                    height: 20,
                  ),

                  //buttons

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        text: 'GET TICKETS',
                        onPressed: () {},
                        color: const Color.fromARGB(255, 138, 148, 108),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        text: 'SHARE LINK',
                        onPressed: () {},
                        color: const Color.fromARGB(255, 233, 237, 201),
                        foreground: const Color.fromARGB(200, 68, 73, 53),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
