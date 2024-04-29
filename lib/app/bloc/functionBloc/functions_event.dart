// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'functions_bloc.dart';

sealed class FunctionsEvent {
  const FunctionsEvent();
}

class DatePickEvent extends FunctionsEvent {}

class DatePickedEvent extends FunctionsEvent {
  final DateTime? date;

  DatePickedEvent({this.date});
}

class TimePickEvent extends FunctionsEvent {}

class FetchCategoryEvent extends FunctionsEvent {}

class UploadDummyEvent extends FunctionsEvent {}

class FetchEventEvent extends FunctionsEvent {}

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

class UpdateEventEvent extends FunctionsEvent {
  final EventModel event;

  UpdateEventEvent({required this.event});
}

class DeleteEvent extends FunctionsEvent {
  final String id;

  DeleteEvent({required this.id});
}

class DeleteConfirmEvent extends FunctionsEvent {}
class DeleteRejectEvent extends FunctionsEvent {}

class SearchEvent extends FunctionsEvent {
  String value;
  SearchEvent({
    required this.value,
  });
}
class ShareEvent extends FunctionsEvent {
  final String title;
  final String desc;
  final String date;
  final String time;
  final String location;
  final String contact;

  ShareEvent({required this.desc,required this.contact, required this.title, required this.date, required this.time, required this.location,});
}
