import 'package:bloc/bloc.dart';


class PasswordCubit extends Cubit<bool> {
  PasswordCubit() : super(false);

  void toggleVisibilty (){
    emit(!state);
  }
}
