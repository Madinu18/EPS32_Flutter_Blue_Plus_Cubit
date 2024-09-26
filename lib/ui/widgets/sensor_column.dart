part of 'widgets.dart';

class SensorColumn extends StatelessWidget {
  final String title;
  final String imagePath;
  final Function(SensorData) dataBuilder;
  final Stream<List<int>>? tempHumiStream;

  const SensorColumn({
    required this.title,
    required this.imagePath,
    required this.dataBuilder,
    this.tempHumiStream,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bluetoothCubit = BlocProvider.of<BluetoothCubit>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(imagePath, width: 100, height: 100),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: blackTextFontTitle),
              (bluetoothCubit.state.connectedDevice == null)
                  ? Text(
                      "Not Conected",
                      style: blackTextFont,
                    )
                  : StreamBuilder<List<int>>(
                      stream: tempHumiStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = String.fromCharCodes(snapshot.data!);
                          final sensorData = SensorData.fromJson(data);
                          return dataBuilder(sensorData);
                        } else {
                          return const Text("Loading...");
                        }
                      },
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
