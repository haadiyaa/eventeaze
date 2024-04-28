import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:eventeaze/app/bloc/functionBloc/functions_bloc.dart';
import 'package:eventeaze/app/model/evenmodel.dart';
import 'package:eventeaze/app/view/widgets/buttons/custombutton.dart';
import 'package:eventeaze/app/view/widgets/textfields/creattext.dart';
import 'package:eventeaze/app/view/widgets/textfields/customdropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class EditEventWrapper extends StatelessWidget {
  const EditEventWrapper({
    super.key,
    required this.event,
  });
  final EventModel event;

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
      child: EditEventPage(
        event: event,
      ),
    );
  }
}

class EditEventPage extends StatefulWidget {
  EditEventPage({super.key, required this.event});
  final EventModel event;

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
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
  TextEditingController? titleController;
  TextEditingController? ticketController;
  TextEditingController? priceController;
  TextEditingController? locationController;
  TextEditingController? cityController;
  TextEditingController? dateController;
  TextEditingController? timeController;
  TextEditingController? descController;
  TextEditingController? contacttController;
  String? imageurl;
  String? date;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.event.eventName);
    ticketController = TextEditingController(text: widget.event.seats);
    priceController = TextEditingController(text: widget.event.ticketPrice);
    locationController = TextEditingController(text: widget.event.location);
    cityController = TextEditingController(text: widget.event.venue);
    dateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd')
            .format(widget.event.eventDate!.toDate())
            .split('-')
            .reversed
            .join('-'));
    timeController = TextEditingController(text: widget.event.eventTime);
    descController = TextEditingController(text: widget.event.eventDesc);
    contacttController = TextEditingController(text: widget.event.contact);
    selectedItem = widget.event.category;
    current = FirebaseAuth.instance.currentUser!;
    imageurl=widget.event.image;
    timestamp=widget.event.eventDate;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 68, 73, 53),
              fontSize: 24,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: BlocConsumer<FunctionsBloc, FunctionsState>(
            listener: (context, state) async {
              if (state is UploadEventImageSuccessState) {
                imageurl = state.image;
              }
              // else if (state is CreateLoadingState) {
              //   showDialog(
              //     context: context,
              //     builder: (context) {
              //       return const Center(
              //         child: SpinKitFadingCircle(
              //           duration: Duration(seconds: 2),
              //           color: Colors.white,
              //         ),
              //       );
              //     },
              //   );
              // }
              if (state is DropdownState) {
                selectedItem = state.value;
                print('state emittteed ${state.value} and $selectedItem');
              }
              if (state is TimePickState) {
                TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  TimeOfDay pickedTime = time;
                }
              }

              if (state is DatePickingState) {
                DateTime? _picked ;
                _picked=timestamp!.toDate();
                _picked =  await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (_picked != null) {
                  DateTime pickedDate = _picked;
                  String formatDate =DateFormat('yyyy-MM-dd').format(pickedDate);
                  dateController!.text = formatDate;
                  timestamp = Timestamp.fromDate(pickedDate);
                }
              }
              if (state is UpdateEventStete) {
                print('state emeitted');
                Navigator.pop(context);
              }
              if (state is UpdateEventErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Upadate Error!')));
              }
            },
            builder: (context, state) => Column(
              children: [
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      CreateText(
                        maxLines: 1,
                        text: 'Event Title',
                        controller: titleController!,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Enter Something';
                          }
                        },
                      ),
                      CustomDropdown(
                        selectedItem: selectedItem,
                        items: _items,
                        validator: (value) {
                          if (value == null) {
                            return 'Please select an item';
                          }
                        },
                      ),
                      CreateText(
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        text: 'Total No. of tickets',
                        controller: ticketController!,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Enter Something';
                          }
                        },
                      ),
                      CreateText(
                        maxLines: 1,
                        text: "City",
                        controller: cityController!,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Enter Something';
                          }
                        },
                      ),
                      CreateText(
                        maxLines: 1,
                        text: 'Vanue',
                        controller: locationController!,
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
                          BlocProvider.of<FunctionsBloc>(context)
                              .add(DatePickEvent());
                        },
                        keyboardType: TextInputType.none,
                        maxLines: 1,
                        text: "Date",
                        controller: dateController!,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Enter Something';
                          }
                        },
                      ),
                      CreateText(
                        onTap: () {
                          BlocProvider.of<FunctionsBloc>(context)
                              .add(TimePickEvent());
                        },
                        maxLines: 1,
                        text: 'Time',
                        controller: timeController!,
                        keyboardType: TextInputType.none,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Enter Something';
                          }
                        },
                      ),
                      CreateText(
                        maxLines: null,
                        text: 'Description',
                        controller: descController!,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Enter Something';
                          }
                        },
                      ),
                      CreateText(
                        maxLines: 1,
                        text: 'Ticket Price',
                        controller: priceController!,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Enter Something';
                          }
                        },
                      ),
                      CreateText(
                        maxLines: 1,
                        text: 'Contact Number',
                        controller: contacttController!,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Enter Something';
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: StreamBuilder<
                                QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('events')
                                .where('id', isEqualTo: current!.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<FunctionsBloc>(context)
                                          .add(UploadEventImageEvent(
                                              current!.uid));
                                    },
                                    child: imageurl == null
                                        ? state is LoadingState
                                            ? Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor:
                                                    Colors.grey.shade100,
                                                child: const CircleAvatar(
                                                    radius: 40,
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 170, 181, 135),
                                                    child:
                                                        CircularProgressIndicator()),
                                              )
                                            : const CircleAvatar(
                                                radius: 40,
                                                backgroundColor: Color.fromARGB(
                                                    255, 103, 110, 81),
                                                child: Icon(
                                                  Icons.add_a_photo_outlined,
                                                  color: Colors.white,
                                                  size: 35,
                                                ),
                                              )
                                        : CircleAvatar(
                                            radius: 40,
                                            backgroundImage:
                                                NetworkImage(imageurl!),
                                          ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text(
                                    'Upload Image',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 81, 87, 64),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                      CustomButton(
                        text: 'Save & Publish',
                        color: Color.fromARGB(255, 81, 87, 64),
                        onPressed: () {
                          print('$selectedItem dfghjmnbvcvbn');
                          print('button clickedd');
                          if (imageurl == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please select an Image')),
                            );
                          } else {
                            if (_key.currentState!.validate()) {
                              print('button validaation');

                              if (timestamp != null) {
                                final EventModel event = EventModel(
                                  id: widget.event.id,
                                  eventId: widget.event.eventId,
                                  eventName: titleController!.text.trim(),
                                  eventDate: timestamp,
                                  eventDesc: descController!.text.trim(),
                                  location: locationController!.text.trim(),
                                  venue: cityController!.text.trim(),
                                  seats: ticketController!.text.trim(),
                                  contact: contacttController!.text.trim(),
                                  image: imageurl,
                                  category: selectedItem,
                                  ticketPrice: priceController!.text.trim(),
                                  eventTime: timeController!.text.trim(),
                                );

                                BlocProvider.of<FunctionsBloc>(context)
                                    .add(UpdateEventEvent(event: event));
                              } else {
                                print('timestamp nulllll');
                              }
                            }
                          }
                        },
                      ),
                      CustomButton(
                        text: 'Cancel',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        foreground: Color.fromARGB(255, 81, 87, 64),
                        color: Color.fromARGB(255, 241, 255, 196),
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