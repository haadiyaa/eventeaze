import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:eventeaze/app/bloc/functionBloc/functions_bloc.dart';
import 'package:eventeaze/app/model/evenmodel.dart';
import 'package:eventeaze/app/view/common/buttons/custombutton.dart';
import 'package:eventeaze/app/view/screens/createevent/widgets/creattext.dart';
import 'package:eventeaze/app/view/screens/createevent/widgets/customdropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
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
    'Music',
    'Family',
    'Business',
    'Birthday',
    'Health',
    'Food',
    'Education',
  ];

  final List<String> _itemsss = [
    'Paid',
    'Free',
  ];

  String? selectedItem;
  String? selected;

  User? current;
  Timestamp? timestamp;
  final _key = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();

  final TextEditingController ticketController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  final TextEditingController descController = TextEditingController();

  final TextEditingController contacttController = TextEditingController();
  final String eventId = const Uuid().v4();
  String? imageurl;
  String? date;
  TimeOfDay selectedTime = TimeOfDay.now();

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
          child: BlocConsumer<FunctionsBloc, FunctionsState>(
            listener: (context, state) async {
              if (state is UploadEventImageSuccessState) {
                imageurl = state.image;
              }
              if (state is DropdownState) {
                selectedItem = state.value;
                print('state emittteed ${state.value} and $selectedItem');
              }
              if (state is DropdownFreeState) {
                selected=state.value;
              }
              // this.expands = false,
              if (state is TimePickState) {
                TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                  initialEntryMode: TimePickerEntryMode.dial,
                );
                if (time != null) {
                  timeController.text = time.format(context);
                }
              }

              if (state is DatePickingState) {
                DateTime? _picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
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
                print('state emeitted');
                Navigator.pop(context);
              }
            },
            builder: (context, state) => Column(
              children: [
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      CreateText(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s{2,}')),
                          LengthLimitingTextInputFormatter(20)
                        ],
                        keyboardType: TextInputType.name,
                        maxLines: 1,
                        text: 'Event Title',
                        controller: titleController,
                        validator: (value) {
                          final name = RegExp(r'^[A-Za-z\s]+$');
                          if (value!.isEmpty) {
                            return 'User name can\'t be empty';
                          } else if (!name.hasMatch(value)) {
                            return "Enter a valid name";
                          } else if (value.length < 3) {
                            return 'Title should be atleast 3 characters long';
                          }
                          return null;
                        },
                      ),
                      CustomDropdown(
                        onChanged: (value) {
                          BlocProvider.of<FunctionsBloc>(context)
                              .add(DropdownEvent(value: value));
                          print('oooonnnn change$selectedItem paassseeeddd');
                        },
                        selectedItem: selectedItem,
                        items: _items,
                        validator: (value) {
                          if (value == null) {
                            return 'Please select an item';
                          }
                          return null;
                        },
                        text: 'Category',
                      ),
                      CustomDropdown(
                        onChanged: (value){
                          BlocProvider.of<FunctionsBloc>(context).add(DropdownFreeEvent(value: value));
                        },
                        selectedItem: selected,
                        validator: (value) {
                          if (value == null) {
                            return 'Please select an item';
                          }
                          return null;
                        },
                        items: _itemsss,
                        text: 'Select',
                      ),
                      CreateText(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          LengthLimitingTextInputFormatter(6)
                        ],
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        text: 'Total No. of tickets',
                        controller: ticketController,
                        validator: (value) {
                          final reg2 = RegExp(r"^\d+$");
                          if (value!.isEmpty) {
                            return 'Number can\'t be empty';
                          } else if (!reg2.hasMatch(value)) {
                            return 'Enter a valid number of tickets';
                          }
                          return null;
                        },
                      ),
                      CreateText(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s{2,}')),
                          LengthLimitingTextInputFormatter(25)
                        ],
                        keyboardType: TextInputType.name,
                        maxLines: 1,
                        text: "City",
                        controller: cityController,
                        validator: (value) {
                          final name = RegExp(r'^[A-Za-z\s\.]+$');
                          if (value!.isEmpty) {
                            return 'City can\'t be empty';
                          } else if (!name.hasMatch(value)) {
                            return "Enter a valid City";
                          } else if (value.length < 3) {
                            return 'City be atleast 3 characters long';
                          }
                          return null;
                        },
                      ),
                      CreateText(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s{2,}')),
                          LengthLimitingTextInputFormatter(30)
                        ],
                        keyboardType: TextInputType.name,
                        maxLines: 1,
                        text: 'Vanue',
                        controller: locationController,
                        validator: (value) {
                          final name = RegExp(r'^[A-Za-z\s\S]+$');
                          if (value!.isEmpty) {
                            return 'Venue name can\'t be empty';
                          } else if (!name.hasMatch(value)) {
                            return "Enter a valid name";
                          } else if (value.length < 3) {
                            return 'Venue should be atleast 3 characters long';
                          }
                          return null;
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
                        controller: dateController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Plaese select a date!';
                          }
                          return null;
                        },
                      ),
                      CreateText(
                        onTap: () {
                          BlocProvider.of<FunctionsBloc>(context)
                              .add(TimePickEvent());
                        },
                        maxLines: 1,
                        text: 'Time',
                        controller: timeController,
                        keyboardType: TextInputType.none,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Plaese select a time!';
                          }
                          return null;
                        },
                      ),
                      CreateText(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s{2,}')),
                        ],
                        keyboardType: TextInputType.name,
                        maxLines: null,
                        text: 'Description',
                        controller: descController,
                        validator: (value) {
                          final name = RegExp(r'^[A-Za-z\s\S\d]+$');
                          if (value!.isEmpty) {
                            return 'Description can\'t be empty';
                          } else if (!name.hasMatch(value)) {
                            return "Enter a paragraph";
                          } else if (value.length < 3) {
                            return 'Description should be atleast 3 characters long';
                          }
                          return null;
                        },
                      ),selected=='Free'?const SizedBox():
                      CreateText(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          LengthLimitingTextInputFormatter(6)
                        ],
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        text: 'Ticket Price',
                        controller: priceController,
                        validator: (value) {
                          final reg2 = RegExp(r"^\d{2,}$");
                          if (value!.isEmpty) {
                            return 'Ticket price can\'t be empty';
                          } else if (!reg2.hasMatch(value)) {
                            return 'Enter a valid number Price';
                          }
                          return null;
                        },
                      ),
                      CreateText(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          LengthLimitingTextInputFormatter(10)
                        ],
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        text: 'Contact Number',
                        controller: contacttController,
                        validator: (value) {
                          final reg2 = RegExp(r"^[6789]\d{9}$");
                          if (value!.isEmpty) {
                            return 'Number can\'t be empty';
                          } else if (value.length > 10) {
                            return "number exact 10";
                          } else if (!reg2.hasMatch(value)) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: StreamBuilder<
                                QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('events')
                                .where('id', isEqualTo: eventId)
                                .snapshots(),
                            builder: (context, snapshot) {
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<FunctionsBloc>(context)
                                          .add(UploadEventImageEvent(eventId));
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
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: CachedNetworkImage(
                                                imageUrl: imageurl!,
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade300,
                                                  highlightColor:
                                                      Colors.grey.shade100,
                                                  child: Container(
                                                    width: 10,
                                                    height: 10,
                                                    color: Colors.white,
                                                  ),
                                                ),

                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            )),
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
                        color: const Color.fromARGB(255, 81, 87, 64),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          print('$selectedItem category');
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
                                  eventName: titleController.text.trim(),
                                  eventDate: timestamp,
                                  eventDesc: descController.text.trim(),
                                  eventTime: timeController.text.trim(),
                                  location: cityController.text.trim(),
                                  venue: locationController.text.trim(),
                                  seats: ticketController.text.trim(),
                                  contact: contacttController.text.trim(),
                                  image: imageurl,
                                  category: selectedItem,
                                  ticketPrice: priceController.text,
                                  freeOrPaid: selected
                                );
                                BlocProvider.of<FunctionsBloc>(context)
                                    .add(CreateEventEvent(event: event));
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
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.pop(context);
                        },
                        foreground: const Color.fromARGB(255, 81, 87, 64),
                        color: const Color.fromARGB(255, 241, 255, 196),
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
