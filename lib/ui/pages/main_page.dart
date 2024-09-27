part of 'pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  StreamSubscription<BluetoothConnectionState>? connectionSubscription;
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    connectionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothCubit, Bluetooth_State>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("DHT11 Monitoring",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SensorColumn(
                  title: "Temperature",
                  imagePath: 'assets/images/temperature.png',
                  tempHumiStream: tempHumiValue,
                  dataBuilder: (data) {
                    return Text("${data.temperature} °C");
                  }),
              SensorColumn(
                  title: "Humidity",
                  imagePath: "assets/images/humidity.png",
                  tempHumiStream: tempHumiValue,
                  dataBuilder: (data) {
                    return Text("${data.humidity} %");
                  }),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: connectedToDevice
            ? BluetoothDisconnectButton(
                onConnect: () => showDisconnectConfirmation(
                  context,
                  () {
                    BlocProvider.of<BluetoothCubit>(context).disconnectDevice(connectedDevice!);
                  },
                ),
              )
            : BluetoothConnectButton(
                onDisconnect: () {
                  BlocProvider.of<PageCubit>(context).goToBluetoothPage();
                },
              ),
      );
    });
  }
}
