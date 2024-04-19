part of 'functions_bloc.dart';

abstract class FunctionsState extends Equatable {
  const FunctionsState();
  
  
}

class FunctionsInitial extends FunctionsState {
  @override
  List<Object> get props => [];
}

class DatePickingState extends FunctionsState {
  @override
  List<Object> get props => [];
  
}

class DatePickedState extends FunctionsState {
  final String? pickedDate;

  const DatePickedState({ this.pickedDate});
  @override
  List<Object> get props => [pickedDate.toString()];
}

