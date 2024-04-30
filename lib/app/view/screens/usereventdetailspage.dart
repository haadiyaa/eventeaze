import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/bloc/functionBloc/functions_bloc.dart';
import 'package:eventeaze/app/model/evenmodel.dart';
import 'package:eventeaze/app/view/screens/editeventpage.dart';
import 'package:eventeaze/app/view/screens/usereventspage.dart';
import 'package:eventeaze/app/view/widgets/buttons/custombutton.dart';
import 'package:eventeaze/app/view/widgets/design/confirmalert.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/aboutevent.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/detailslisttile.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/eventdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UserEventDetailsWrapper extends StatelessWidget {
  const UserEventDetailsWrapper({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FunctionsBloc(),
      child: UserEventDetailsPage(
        id: id,
      ),
    );
  }
}

class UserEventDetailsPage extends StatelessWidget {
  const UserEventDetailsPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    final functionBloc = BlocProvider.of<FunctionsBloc>(context);
    return BlocListener<FunctionsBloc, FunctionsState>(
      listener: (context, state) {
        if (state is DeleteConfirmState) {
          showDialog(
            context: context,
            builder: (context) => ConfirmAlert(
              msg: 'Are you sure you want to delete this Event?',
              icon: Icons.warning,
              iconBgColor: Colors.red.shade300,
              iconColor: Colors.red,
              onConfirm: () {
                functionBloc.add(DeleteEvent(id: id));
              },
              onReject: () {
                functionBloc.add(DeleteRejectEvent());
              },
            ),
          );
        } else if (state is DeleteEventState) {
          Navigator.pop(context);
          Navigator.pop(context);
        } else if (state is DeleteRejectState) {
          Navigator.pop(context);
        }
      },
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('events')
              .doc(id)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final event = snapshot.data!.data() as Map<String, dynamic>?;
              if (event != null) {
                return Scaffold(
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
                              AboutEvent(
                                  desc: '${event['ticketPrice']} INR',
                                  title: 'TICKET PRICE'),
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
                                    text: 'Edit Event',
                                    onPressed: () {
                                      final EventModel myEvent = EventModel(
                                        eventId: event['eventId'],
                                        id: event['id'],
                                        eventName: event['eventName'],
                                        eventDate: event['eventDate'],
                                        eventDesc: event['eventDesc'],
                                        eventTime: event['eventTime'],
                                        location: event['location'],
                                        venue: event['venue'],
                                        seats: event['seats'],
                                        contact: event['contact'],
                                        image: event['image'],
                                        category: event['category'],
                                        ticketPrice: event['ticketPrice'],
                                      );
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => EditEventWrapper(
                                                    event: myEvent,
                                                  )));
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
                                    text: 'Delete Event',
                                    onPressed: () {
                                      functionBloc.add(DeleteConfirmEvent());
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
                                    text: 'Share ',
                                    onPressed: () {
                                      functionBloc.add(
                                        ShareEvent(
                                          desc: event['eventDesc'],
                                          contact: event['contact'],
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
                );
              }
            }
//----------------------------------------------------------------------------------------------------
            return EventDetail();
          }),
    );
  }
}
