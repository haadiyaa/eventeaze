// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/model/evenmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:eventeaze/app/bloc/functionBloc/functions_bloc.dart';
import 'package:eventeaze/app/bloc/notificationsBloc/notifications_bloc.dart';
import 'package:eventeaze/app/serivices/notificationservices.dart';
import 'package:eventeaze/app/view/widgets/buttons/custombutton.dart';
import 'package:eventeaze/app/view/widgets/design/confirmalert.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/detailslisttile.dart';
import 'package:eventeaze/app/view/widgets/design/eventdetails/eventdetail.dart';

class BookingPageWrapper extends StatelessWidget {
  const BookingPageWrapper({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FunctionsBloc(),
        ),
        BlocProvider(
          create: (context) => NotificationsBloc(),
        ),
      ],
      child: BookingPage(
        id: id,
      ),
    );
  }
}

class BookingPage extends StatelessWidget {
  BookingPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;
  final NotificationServices notificationServices = NotificationServices();
  final User? _user = FirebaseAuth.instance.currentUser;

  // void showSnackBar(String message)=>ScaffoldMessenger.of(context)

  @override
  Widget build(BuildContext context) {
    final functionBloc = BlocProvider.of<FunctionsBloc>(context);
    final notification = BlocProvider.of<NotificationsBloc>(context);
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
        } else if (state is NotAvailableState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Oops! Tickets not Availabe!')));
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
                      BlocListener<NotificationsBloc, NotificationsState>(
                        listener: (context, state) {
                          if (state is JoinLoadingState) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                  child: SpinKitFadingCircle(
                                    duration: Duration(seconds: 2),
                                    color: Colors.white,
                                  ),
                                );
                              },
                            );
                          } else if (state is JoinEventState) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Successfully Joined Event')));
                          }
                        },
                        child: SliverToBoxAdapter(
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
                                event['ticketPrice']!=''?
                                AboutEventData(
                                  desc: '${event['ticketPrice']} INR',
                                  title: 'TICKET PRICE',
                                ):const SizedBox(),
                                event['ticketPrice']!=''?const Divider():SizedBox(),
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
                                StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(event['id'])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final user = snapshot.data?.data()
                                            as Map<String, dynamic>?;
                                        if (user != null) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              StreamBuilder<DocumentSnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('users')
                                                    .doc(_user!.uid)
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    final user2 =
                                                        snapshot.data?.data()
                                                            as Map<String,
                                                                dynamic>?;
                                                    if (user2 != null) {
                                                      
                                                      return CustomButton(
                                                        text: 'Join',
                                                        onPressed: int.parse(event[
                                                                    'seats']) <=
                                                                0
                                                            ? () {
                                                                functionBloc.add(
                                                                    NotAvailableEvent());
                                                              }
                                                            : () async {
                                                              final title='Hey, ${user['username']}';
                                                              final body='${user2['username']} has joined your event!';
                                                              final recieverToken=user[
                                                                          'token']
                                                                      .toString();
                                                                var data = {
                                                                  'to': recieverToken,
                                                                  'priority':
                                                                      'high',
                                                                  'notification':
                                                                      {
                                                                    'title':
                                                                        title,
                                                                    'body':
                                                                        body,
                                                                  },
                                                                  'data': {
                                                                    'type':
                                                                        'msg',
                                                                    'id':
                                                                        '123456',
                                                                  },
                                                                };
                                                                final myEvent =
                                                                    EventModel(
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
                                                                      eventId: event['eventId'],
                                                                      ticketPrice: event['ticketPrice']??'',
                                                                    );
                                                                notification.add(JoinEvent(userid:user2['uid'],recieverId:user['uid'],
                                                                  data: data,
                                                                  seats: event['seats'],
                                                                  eventdetails:myEvent, title: title,
                                                                  body: body,
                                                                ));
                                                              },
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 105, 114, 77),
                                                      );
                                                    }
                                                  }
                                                  return Container();
                                                },
                                              ),
                                            ],
                                          );
                                        }
                                      } else {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomButton(
                                              text: 'Join',
                                              onPressed: () {},
                                              child:
                                                  const CircularProgressIndicator(),
                                            ),
                                          ],
                                        );
                                      }
                                      return Container(
                                        color: Colors.amber,
                                        height: 10,
                                        width: double.infinity,
                                      );
                                      //return const SizedBox();
                                    }),
                              ],
                            ),
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
