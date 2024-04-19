import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:eventeaze/app/bloc/functionBloc/functions_bloc.dart';
import 'package:eventeaze/app/view/widgets/textfields/creattext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class CreateEventPage extends StatelessWidget {
  CreateEventPage({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController ticketController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController contacttController = TextEditingController();

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
                  dateController.text = _picked.toString().split(' ')[0];
                }
              }
            },
            child: Column(
              children: [
                Form(
                  child: Column(
                    children: [
                      CreateText(
                        maxLines: 1,
                        text: 'Event Title',
                        controller: titleController,
                        validator: (p0) {},
                      ),
                      CreateText(
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        text: 'Total No. of tickets',
                        controller: ticketController,
                        validator: (p0) {},
                      ),
                      CreateText(
                        maxLines: 1,
                        text: "City",
                        controller: cityController,
                        validator: (p0) {},
                      ),
                      CreateText(
                        maxLines: 1,
                        text: 'Vanue',
                        controller: locationController,
                        validator: (p0) {},
                      ),
                      CreateText(
                        hintText: 'DD-MM-YYYY',
                        onTap: () {
                          print('daaatttteeee');
                          context.read<FunctionsBloc>().add(DatePickEvent());
                        },
                        keyboardType: TextInputType.datetime,
                        maxLines: 1,
                        text: "Date",
                        controller: dateController,
                        validator: (p0) {},
                      ),
                      CreateText(
                        maxLines: 1,
                        text: 'Time',
                        controller: timeController,
                        validator: (p0) {},
                      ),
                      CreateText(
                        maxLines: null,
                        // expands: true,
                        text: 'Description',
                        controller: descController,
                        validator: (p0) {},
                      ),
                      CreateText(
                        text: 'Contact Number',
                        controller: contacttController,
                        validator: (p0) {},
                      )
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

  // Future<void> _selectDate(BuildContext context) async {
  //   DateTime? _picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //   );
  //   if (_picked != null) {}
  // }
}
