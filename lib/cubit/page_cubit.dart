import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(PageInitial());

  void goToMainPage() {
    emit(GoToMainPage());
  }

  void goToBluetoothPage() {
    emit(GoToBluetoothPage());
  }

  void goToBluetoothOffScreen() {
    emit(GoToBluetoothOffScreen());
  }
}
