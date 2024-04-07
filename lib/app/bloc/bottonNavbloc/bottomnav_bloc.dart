import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottomnav_event.dart';
part 'bottomnav_state.dart';

class BottomnavBloc extends Bloc<BottomnavEvent, BottomnavState> {
  BottomnavBloc() : super(BottomnavInitial(tabIndex: 0)) {
    on<BottomnavEvent>((event, emit) {
      if(event is TabChangeEvent){
        print('tab index: ${event.tabIndex}');
        emit(BottomnavInitial(tabIndex: event.tabIndex));
      }
    });
  }
}
