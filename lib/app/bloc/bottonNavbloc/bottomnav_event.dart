part of 'bottomnav_bloc.dart';

abstract class BottomnavEvent extends Equatable {
  const BottomnavEvent();

  @override
  List<Object> get props => [];
}
class TabChangeEvent extends BottomnavEvent {
  final int tabIndex;

  const TabChangeEvent({required this.tabIndex});
  
  @override
  List<Object> get props => [tabIndex];
}
