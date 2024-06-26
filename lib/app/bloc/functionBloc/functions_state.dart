// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'functions_bloc.dart';

abstract class FunctionsState {
  const FunctionsState();
}

class FunctionsInitial extends FunctionsState {}

class LoadingState extends FunctionsState {}

class UpdateLoadingState extends FunctionsState {}

class CreateLoadingState extends FunctionsState {}

class DatePickingState extends FunctionsState {}

class TimePickState extends FunctionsState {}

class DatePickedState extends FunctionsState {
  final String? pickedDate;

  const DatePickedState({this.pickedDate});
}

class FetchCategoryState extends FunctionsState {
  final List<CategoryModel> list;

  const FetchCategoryState({required this.list});
}

class DropdownState extends FunctionsState {
  final String value;

  const DropdownState({required this.value});
}

class DropdownFreeState extends FunctionsState {
  final String value;

  const DropdownFreeState({required this.value});
}


class ErrorState extends FunctionsState {
  final String message;

  const ErrorState({required this.message});
}

class UploadedDummyState extends FunctionsState {}

class CreateEventState extends FunctionsState {}

class UploadEventImageSuccessState extends FunctionsState {
  final String image;

  UploadEventImageSuccessState({required this.image});
}

class UpdateEventStete extends FunctionsState {}

class UpdateEventErrorState extends FunctionsState {
  final String message;

  UpdateEventErrorState({required this.message});
}

class DeleteEventState extends FunctionsState {}
class DeleteConfirmState extends FunctionsState {}
class DeleteRejectState extends FunctionsState {}
class DeleteEventErrorState extends FunctionsState {
  final String message;

  DeleteEventErrorState({required this.message});
}

class SearchEventState extends FunctionsState {
  String searchName;
  SearchEventState({
    required this.searchName,
  });
}
class ShareState extends FunctionsState {
  
}

class NotAvailableState extends FunctionsState{
  
}

