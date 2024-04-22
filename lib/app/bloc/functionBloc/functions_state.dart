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
class FetchCategoryState extends FunctionsState {

  final List<CategoryModel> list;

  const FetchCategoryState({required this.list});
  @override
  List<Object?> get props => [list]; 
}
class DropdownState extends FunctionsState {
  final String value;

  const DropdownState({required this.value});
  
  @override
  List<Object?> get props => [value];
}

class ErrorState extends FunctionsState{
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class UploadedDummyState extends FunctionsState {

  @override
  List<Object?> get props => [];
}

class CreateEventState extends FunctionsState {
  @override
  List<Object?> get props => [];
  
}
