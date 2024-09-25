part of "pages.dart";

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageCubit, PageState>(
      builder: (context, state) {
        if (state is PageInitial) {
          return const SplashPage();
        } else if (state is GoToMainPage) {
          return const MainPage();
        } else if (state is GoToBluetoothPage) {
          return const BluetoothPage();
        } else {
          return Container();
        }
      },
    );
  }
}
