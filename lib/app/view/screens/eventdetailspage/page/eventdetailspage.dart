import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/bloc/functionBloc/functions_bloc.dart';
import 'package:eventeaze/app/view/screens/eventdetailspage/page/bookingpage.dart';
import 'package:eventeaze/app/view/common/buttons/custombutton.dart';
import 'package:eventeaze/app/view/screens/eventdetailspage/widgets/aboutevent.dart';
import 'package:eventeaze/app/view/screens/eventdetailspage/widgets/detailslisttile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FunctionsBloc(),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('events')
              .doc(id)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final event = snapshot.data!.data() ;
              if (event != null) {
                final bloc = BlocProvider.of<FunctionsBloc>(context);
                return BlocListener<FunctionsBloc, FunctionsState>(
                  listener: (context, state) {},
                  child: Scaffold(
                    body: CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          backgroundColor:
                              const Color.fromARGB(255, 105, 114, 77),
                          leading: const BackButton(
                            color: Colors.white,
                          ),
                          pinned: true,
                          expandedHeight: 200,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(event['image']),
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
                            title: Text(event['eventName']),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DetailsListTile(
                                  title: DateFormat('yyyy-MM-dd')
                                      .format(event['eventDate'].toDate())
                                      .split('-')
                                      .reversed
                                      .join('-'),
                                  subtitle: event['eventTime'],
                                  icon: Icons.calendar_month_outlined,
                                ),
                                DetailsListTile(
                                  title: event['location'],
                                  subtitle: event['venue'],
                                  icon: Icons.location_on_outlined,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //description

                                AboutEvent(
                                  title: 'ABOUT EVENT',
                                  desc: event['eventDesc'],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                //tickets
                                AboutEvent(
                                    desc: event['seats'],
                                    title: 'AVAILABLE SEATS'),
                                const SizedBox(
                                  height: 10,
                                ),
                                //ticket price
                                event['ticketPrice']!=''?
                                AboutEvent(
                                    desc: '${event['ticketPrice']} INR',
                                    title: 'TICKET PRICE'):const SizedBox(),
                                const SizedBox(
                                  height: 20,
                                ),

                                //contact
                                AboutEvent(
                                    desc: event['contact'], title: 'CONTACT'),
                                const SizedBox(
                                  height: 20,
                                ),

                                //buttons
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomButton(
                                      text: 'BOOK TICKETS',
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (_)=> BookingPageWrapper(id:event['eventId'])));
                                      },
                                      color: const Color.fromARGB(
                                          255, 138, 148, 108),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomButton(
                                      text: 'SHARE',
                                      onPressed: () {
                                        bloc.add(
                                          ShareEvent(
                                            desc: event['eventDesc'],contact: event['contact'],
                                            title: event['eventName'],
                                            date: DateFormat('yyyy-MM-dd')
                                                .format(
                                                    event['eventDate'].toDate())
                                                .split('-')
                                                .reversed
                                                .join('-'),
                                            time: event['eventTime'],
                                            location:
                                                '${event['location']}, ${event['venue']}',
                                                
                                          ),
                                        );
                                      },
                                      color: const Color.fromARGB(
                                          255, 233, 237, 201),
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
                  ),
                );
              }
            }
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
          }),
    );
  }
}
