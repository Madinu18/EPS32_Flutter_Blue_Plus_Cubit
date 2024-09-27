part of 'page_cubit.dart';

@immutable
abstract class PageState extends Equatable {
  const PageState();

  @override
  List<Object?> get props => [];
}

class PageInitial extends PageState {}

class GoToMainPage extends PageState {}

class GoToBluetoothPage extends PageState {}

class GoToBluetoothOffScreen extends PageState {}



// @immutable
// sealed class PageState {}

// final class PageInitial extends PageState {}

// final class GoToMainPage extends PageState {
//   GoToMainPage();
// }

// final class GoToBluetoothPage extends PageState {
//   GoToBluetoothPage();
// }

// final class GoToBluetoothOffScreen extends PageState {
//   GoToBluetoothOffScreen();
// }
