import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dotindicator_event.dart';
part 'dotindicator_state.dart';

class DotindicatorBloc extends Bloc<DotindicatorEvent, DotindicatorState> {
  DotindicatorBloc() : super(DotindicatorState()) {
    on<DotindicatorEvent>((event, emit) {
      emit(DotindicatorState(page: state.page));
    });
  }
}
