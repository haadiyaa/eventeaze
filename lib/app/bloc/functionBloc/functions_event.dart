// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'functions_bloc.dart';

sealed class FunctionsEvent extends Equatable {
  const FunctionsEvent();
}

class DatePickEvent extends FunctionsEvent {
  @override
  List<Object> get props => [];
}


class DatePickedEvent extends FunctionsEvent {
  final DateTime? date;

  DatePickedEvent({this.date});

  @override
  List<Object> get props => [date.toString()];
}

class FetchCategoryEvent extends FunctionsEvent {
  @override
  List<Object?> get props => [];
}

class UploadDummyEvent extends FunctionsEvent {
  @override
  List<Object?> get props => [];
}

class FetchEventEvent extends FunctionsEvent {
  @override
  List<Object?> get props => [];
}

class DropdownEvent extends FunctionsEvent {
  final String? value;

  const DropdownEvent({required this.value});
  @override
  List<Object?> get props => [value];
}

class CreateEventEvent extends FunctionsEvent {
  final EventModel event;

  const CreateEventEvent({required this.event});
  @override
  List<Object?> get props => [event];
}

class UploadEventImageEvent extends FunctionsEvent {
  String eventId;
  UploadEventImageEvent(this.eventId);
  @override
  List<Object?> get props => [eventId];
}
