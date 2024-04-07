part of 'bottomnav_bloc.dart';

abstract class BottomnavState extends Equatable {
  const BottomnavState({required this.tabIndex});
  final int tabIndex;

  @override
  List<Object> get props => [tabIndex];
}

class BottomnavInitial extends BottomnavState {
  BottomnavInitial({required super.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}
