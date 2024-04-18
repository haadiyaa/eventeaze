import 'package:eventeaze/app/bloc/authBloc/auth_bloc.dart';
import 'package:eventeaze/app/view/widgets/textfields/creattext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventWrapper extends StatelessWidget {
  const CreateEventWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: CreateEventPage(),
    );
  }
}

class CreateEventPage extends StatelessWidget {
  CreateEventPage({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController ticketController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Form(
              child: Column(
                children: [
                  CreateText(
                    text: 'Event Title',
                    controller: titleController,
                  ),
                  CreateText(
                    text: 'Total No. of tickets',
                    controller: ticketController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
