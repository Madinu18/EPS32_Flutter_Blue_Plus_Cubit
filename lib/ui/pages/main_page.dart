part of 'pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  StreamSubscription<BluetoothConnectionState>? connectionSubscription;

  @override
  void initState() {
    final bluetoothCubit = BlocProvider.of<BluetoothCubit>(context);
    if (bluetoothCubit.state.connectedDevice != null) {
      connectionSubscription = bluetoothCubit
          .state.connectedDevice!.connectionState
          .listen((BluetoothConnectionState state) {
        if (state == BluetoothConnectionState.disconnected) {
          bluetoothCubit.disconnectDevice();
          _showDisconnectDialog();
        }
      });
    }
    super.initState();
  }

  Map<String, dynamic> parseJsonData(String data) {
    try {
      return {
        "temperature": double.parse(
            RegExp(r'"temperature":(\d+)').firstMatch(data)?.group(1) ?? "NaN"),
        "humidity": double.parse(
            RegExp(r'"humidity":(\d+)').firstMatch(data)?.group(1) ?? "NaN"),
      };
    } catch (e) {
      return {"temperature": "NaN", "humidity": "NaN"};
    }
  }

  Widget _buildSensorColumn(String title, String imagePath,
      Function(Map<String, dynamic>) dataBuilder) {
    return BlocBuilder<BluetoothCubit, Bluetooth_State>(
        builder: (context, state) {
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
                  Text(title, style: const TextStyle(fontSize: 16)),
                  StreamBuilder<List<int>>(
                    stream: state.tempHumiStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String data = String.fromCharCodes(snapshot.data!);
                        var decodedData = parseJsonData(data);
                        return dataBuilder(decodedData);
                      } else {
                        return const Text("Loading...");
                      }
                    },
                  ),
                ],
              ))
        ],
      );
    });
  }

  Widget buildBluetoothConnectButton(BuildContext context) {
    return BlocBuilder<BluetoothCubit, Bluetooth_State>(
        builder: (context, state) {
      return SizedBox(
        width: 200.0,
        height: 60.0,
        child: FloatingActionButton(
          onPressed: () async {
            if (state.isBluetoothON != BluetoothAdapterState.on) {
              context.read<PageCubit>().goToBluetoothPage();
            } else {
              try {
                if (Platform.isAndroid) {
                  await FlutterBluePlus.turnOn();
                }
              } catch (e) {
                print("Turning On Bluetooth Error: $e");
              }
            }
          },
          backgroundColor: Colors.blue,
          tooltip: 'Connect to a device',
          child: const Icon(Icons.bluetooth),
        ),
      );
    });
  }

  Widget buildBluetoothDisconnectButton(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 60.0,
      child: FloatingActionButton(
        onPressed: _showDisconnectConfirmation,
        backgroundColor: Colors.red,
        tooltip: 'Disconect from device',
        child: const Icon(Icons.bluetooth_disabled),
      ),
    );
  }

  void _showDisconnectDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Device Disconnected'),
          content: const Text('The device has been disconnected.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                GoToMainPage();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _disconnectDevice() async {
    final bluetoothCubit = context.read<BluetoothCubit>();
    bluetoothCubit.disconnectDevice();
  }

  void _showDisconnectConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Disconnect'),
          content:
              const Text('Are you sure you want to disconnect the device?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _disconnectDevice();
                Navigator.of(context).pop();
              },
              child: const Text('Disconnect'),
            ),
          ],
        );
      },
    );
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
              _buildSensorColumn("Temperature", 'assets/images/temperature.png',
                  (data) {
                return Text("${data['temperature']} °C");
              }),
              _buildSensorColumn("Humidity", "assets/images/humidity.png",
                  (data) {
                return Text("${data['humidity']} %");
              }),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: state.isConnected
            ? buildBluetoothDisconnectButton(context)
            : buildBluetoothConnectButton(context),
      );
    });
  }
}
