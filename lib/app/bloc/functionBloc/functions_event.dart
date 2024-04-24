// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'functions_bloc.dart';

sealed class FunctionsEvent  {
  const FunctionsEvent();
}

class DatePickEvent extends FunctionsEvent {
}


class DatePickedEvent extends FunctionsEvent {
  final DateTime? date;

  DatePickedEvent({this.date});
}

class TimePickEvent extends FunctionsEvent {
  
}

class FetchCategoryEvent extends FunctionsEvent {
}

class UploadDummyEvent extends FunctionsEvent {
}

class FetchEventEvent extends FunctionsEvent {
}

class DropdownEvent extends FunctionsEvent {
  final String? value;

  const DropdownEvent({required this.value});
}

class CreateEventEvent extends FunctionsEvent {
  final EventModel event;

  const CreateEventEvent({required this.event});
}

class UploadEventImageEvent extends FunctionsEvent {
  String eventId;
  UploadEventImageEvent(this.eventId);
}
