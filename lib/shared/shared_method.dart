part of 'shared.dart';

Stream<int> streamCheckDataAutoConnect() {
  StreamController<int>? streamController;
  Timer? timer;
  Duration timerInterval = const Duration(seconds: 1);
  int counter = 0;

  void stopTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
      counter = 0;
      streamController!.close();
    }
  }

  void pauseTimer() {
    if (timer != null) {
      timer!.cancel();
    }
  }

  void tick(_) {
    counter ++;
    streamController!.add(counter);
  }

  void startTimer() {
    timer = Timer.periodic(timerInterval, tick);
  }

  streamController = StreamController<int>(
    onListen: startTimer,
    onCancel: stopTimer,
    onResume: startTimer,
    onPause: pauseTimer,
  );

  return streamController.stream;
}

Future<void> showSnackBarDialog(
  String value,
  BuildContext context,
  Color color,
  Duration duration,
) async =>
    await ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value),
        backgroundColor: color,
        duration: duration,
      ),
    );
