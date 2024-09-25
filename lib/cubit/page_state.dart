part of 'page_cubit.dart';

@immutable
sealed class PageState {}

final class PageInitial extends PageState {}

final class GoToMainPage extends PageState {
  GoToMainPage();
}

final class GoToBluetoothPage extends PageState {
  GoToBluetoothPage();
}
