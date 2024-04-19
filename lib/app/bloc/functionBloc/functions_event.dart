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

  DatePickedEvent({ this.date});

  @override
  List<Object> get props => [date.toString()];
}
