
import 'package:eventeaze/app/view/widgets/buttons/custombutton.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/aboutevent.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/detailslisttile.dart';
import 'package:flutter/material.dart';

class EventDetail extends StatelessWidget {
  const EventDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: const Color.fromARGB(255, 105, 114, 77),
            leading: const BackButton(
              color: Colors.white,
            ),
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(),
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
              title: const Text(''),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DetailsListTile(
                    title: '',
                    subtitle: '',
                    icon: Icons.calendar_month_outlined,
                  ),
                  const DetailsListTile(
                    title: '',
                    subtitle: '',
                    icon: Icons.location_on_outlined,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //description
    
                  const AboutEvent(
                    title: '',
                    desc: '',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
    
                  //tickets
                  const AboutEvent(desc: '', title: ''),
                  const SizedBox(
                    height: 10,
                  ),
                  //ticket price
                  const AboutEvent(desc: '', title: ''),
                  const SizedBox(
                    height: 20,
                  ),
    
                  //contact
    
                  const AboutEvent(desc: '', title: ''),
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
                        foreground:
                            const Color.fromARGB(200, 68, 73, 53),
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
