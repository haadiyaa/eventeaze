import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:eventeaze/app/bloc/functionBloc/functions_bloc.dart';
import 'package:eventeaze/app/model/evenmodel.dart';
import 'package:eventeaze/app/view/widgets/buttons/custombutton.dart';
import 'package:eventeaze/app/view/widgets/textfields/creattext.dart';
import 'package:eventeaze/app/view/widgets/textfields/customdropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CreateEventWrapper extends StatelessWidget {
  const CreateEventWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => FunctionsBloc(),
        ),
      ],
      child: CreateEventPage(),
    );
  }
}

class CreateEventPage extends StatefulWidget {
  CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final List<String> _items = [
    'Sports',
    'Art',
    'Cultural',
    'Family',
    'Business',
    'Birthday',
    'Health',
    'Food',
    'Education'
  ];

  String? selectedItem;

  User? current;
  Timestamp? timestamp;
  final _key = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();

  final TextEditingController ticketController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  final TextEditingController timeController = TextEditingController();

  final TextEditingController descController = TextEditingController();

  final TextEditingController contacttController = TextEditingController();
  final String eventId = Uuid().v4();


  @override
  void initState() {
    super.initState();
    current = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create Event',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 68, 73, 53),
              fontSize: 24,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: BlocListener<FunctionsBloc, FunctionsState>(
            listener: (context, state) async {
              if (state is DatePickingState) {
                DateTime? _picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (_picked != null) {
                  DateTime pickedDate = _picked;
                  String formatDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  dateController.text = formatDate;
                  timestamp = Timestamp.fromDate(pickedDate);
                }
              }
              if (state is CreateEventState) {
                Navigator.pop(context);
              }
            },
            child: Column(
              children: [
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      CreateText(
                        maxLines: 1,
                        text: 'Event Title',
                        controller: titleController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Enter Something';
                          }
                        },
                      ),
                      CustomDropdown(selectedItem: selectedItem, items: _items),
                      CreateText(
                        
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        text: 'Total No. of tickets',
                        controller: ticketController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Enter Something';
                          }
                        },
                      ),
                      CreateText(
                        maxLines: 1,
                        text: "City",
                        controller: cityController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Enter Something';
                          }
                        },
                      ),
                      CreateText(
                        maxLines: 1,
                        text: 'Vanue',
                        controller: locationController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Enter Something';
                          }
                        },
                      ),
                      CreateText(
                        hintText: 'YYYY-MM-DD',
                        onTap: () {
                          print('daaatttteeee');
                          context.read<FunctionsBloc>().add(DatePickEvent());
                        },
                        keyboardType: TextInputType.datetime,
                        maxLines: 1,
                        text: "Date",
                        controller: dateController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Enter Something';
                          }
                        },
                      ),
                      CreateText(
                        maxLines: 1,
                        text: 'Time',
                        controller: timeController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Enter Something';
                          }
                        },
                      ),
                      CreateText(
                        maxLines: null,
                        // expands: true,
                        text: 'Description',
                        controller: descController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Enter Something';
                          }
                        },
                      ),
                      CreateText(
                        maxLines: 1,
                        text: 'Contact Number',
                        controller: contacttController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Enter Something';
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('events').where('eventId',isEqualTo: eventId).snapshots(),
                          builder: (context, snapshot) {
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<FunctionsBloc>(context)
                                        .add(UploadEventImageEvent(eventId));
                                  },
                                  child: const CircleAvatar(
                                    radius: 40,
                                    backgroundColor:
                                        Color.fromARGB(255, 170, 181, 135),
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  'Upload Image',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromARGB(255, 123, 131, 98),
                                  ),
                                ),
                              ],
                            );
                          }
                        ),
                      ),
                      CustomButton(
                        text: 'Save & Publish',
                        color: const Color.fromARGB(255, 138, 148, 108),
                        onPressed: () {
                          if (!_key.currentState!.validate()) {
                            if (timestamp != null) {
                              final EventModel event = EventModel(
                                eventId:current!.uid,
                                id:  eventId,
                                eventName: titleController.text.trim(),
                                eventDate: timestamp,
                                eventDesc: descController.text.trim(),
                                eventTime: timeController.text.trim(),
                                location: cityController.text.trim(),
                                venue: locationController.text.trim(),
                                seats: ticketController.text.trim(),
                                contact: contacttController.text.trim(),
                                category: selectedItem,
                              );
                              BlocProvider.of<FunctionsBloc>(context)
                                  .add(CreateEventEvent(event: event));
                            }
                          }
                        },
                      ),
                      CustomButton(
                        text: 'Cancel',
                        onPressed: () {},
                        foreground: const Color.fromARGB(255, 138, 148, 108),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
