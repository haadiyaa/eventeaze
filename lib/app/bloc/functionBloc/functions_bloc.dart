import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'functions_event.dart';
part 'functions_state.dart';

class FunctionsBloc extends Bloc<FunctionsEvent, FunctionsState> {
  FunctionsBloc() : super(FunctionsInitial()) {
    on<FunctionsEvent>((event, emit) {
    });
    on<DatePickEvent>(_datePick);
  }


  FutureOr<void> _datePick(DatePickEvent event, Emitter<FunctionsState> emit) {
    emit(DatePickingState());
  }
}
