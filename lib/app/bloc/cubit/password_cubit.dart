import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


class PasswordCubit extends Cubit<bool> {
  PasswordCubit() : super(false);

  void toggleVisibilty (){
    emit(!state);
  }
}
