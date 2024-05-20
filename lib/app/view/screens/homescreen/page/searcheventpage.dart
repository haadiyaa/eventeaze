import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/bloc/functionBloc/functions_bloc.dart';
import 'package:eventeaze/app/view/screens/eventdetailspage/page/eventdetailspage.dart';
import 'package:eventeaze/app/view/screens/profilescreen/page/usereventdetailspage.dart';
import 'package:eventeaze/app/view/common/design/mycustomsearch.dart';
import 'package:eventeaze/app/view/common/shimmers/shimmersearch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SearchEventWrapper extends StatelessWidget {
  const SearchEventWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FunctionsBloc(),
      child: SearchEventPage(),
    );
  }
}

class SearchEventPage extends StatefulWidget {
  SearchEventPage({super.key});

  @override
  State<SearchEventPage> createState() => _SearchEventPageState();
}

class _SearchEventPageState extends State<SearchEventPage> {
  User? currentUser;
  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  var searchName = '';

  @override
  Widget build(BuildContext context) {
    final function = BlocProvider.of<FunctionsBloc>(context);
    return BlocBuilder<FunctionsBloc, FunctionsState>(
      builder: (context, state) {
        if (state is SearchEventState) {
          searchName = state.searchName.toLowerCase();
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            title: MyCustomSearchBar(
              onChange: (value) {
                function.add(SearchEvent(value: value));
              },
            ),
            actions: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          body: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('events').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong!'),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const ShimmerSearch();
                } else if (snapshot.data == null) {
                  return const Center(
                    child: Text('null!'),
                  );
                }

                final filteredEvents = snapshot.data!.docs.where((event) {
                  final eventName = event['eventName'].toString().toLowerCase();
                  return eventName.contains(searchName);
                }).toList();

                return filteredEvents.isEmpty
                    ? const Center(
                        child: Text('No Events found!',style: TextStyle(fontWeight: FontWeight.w500),),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              height: MediaQuery.of(context).size.height,
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 5,
                                ),
                                shrinkWrap: true,
                                itemCount: filteredEvents.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var data = filteredEvents[index];
                                  return Card(
                                    color: const Color.fromARGB(
                                        255, 248, 255, 224),
                                    elevation: 10,
                                    child: ListTile(
                                      onTap: () {
                                        if (data['id'] == currentUser!.uid) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      UserEventDetailsWrapper(
                                                          id: data[
                                                              'eventId'])));
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => EventDetailsPage(
                                                  id: data['eventId']),
                                            ),
                                          );
                                        }
                                      },
                                      textColor:
                                          const Color.fromARGB(255, 68, 73, 53),
                                      title: Text(data['eventName']),
                                      subtitle: Text(DateFormat('yyyy-MM-dd')
                                          .format(data['eventDate'].toDate())
                                          .split('-')
                                          .reversed
                                          .join('-')),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
              }),
        );
      },
    );
  }
}
