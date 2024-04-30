import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/bloc/functionBloc/functions_bloc.dart';
import 'package:eventeaze/app/view/widgets/design/confirmalert.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/detailslisttile.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/eventdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BookingPageWrapper extends StatelessWidget {
  const BookingPageWrapper({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FunctionsBloc(),
      child: BookingPage(
        id: id,
      ),
    );
  }
}

class BookingPage extends StatelessWidget {
  const BookingPage({super.key, required this.id});
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

                              //tickets
                              AboutEventData(
                                desc: event['seats'],
                                title: 'AVAILABLE SEATS',
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 10,
                              ),
                              //ticket price
                              AboutEventData(
                                desc: '${event['ticketPrice']} INR',
                                title: 'TICKET PRICE',
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 10,
                              ),

                              //contact

                              AboutEventData(
                                desc: event['contact'],
                                title: 'CONTACT',
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 20,
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
            return const EventDetail();
          }),
    );
  }
}

class AboutEventData extends StatelessWidget {
  const AboutEventData({super.key, required this.desc, required this.title});

  final String desc, title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(200, 68, 73, 53),
                fontSize: 16),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            desc,
            style: const TextStyle(
              color: Color.fromARGB(225, 68, 73, 53),
            ),
          ),
        ],
      ),
    );
  }
}
