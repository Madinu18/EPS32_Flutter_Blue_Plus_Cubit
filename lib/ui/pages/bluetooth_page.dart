part of 'pages.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  @override
  void initState() {
    super.initState();
    context.read<BluetoothCubit>().startScan();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothCubit, Bluetooth_State>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Scanning Bluetooth",
                style: TextStyle(fontWeight: FontWeight.bold)),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context
                    .read<PageCubit>()
                    .goToMainPage(); // Go back to the previous page
              },
            ),
          ),
          body: buildDeviceList(state),
          floatingActionButton: buildScanButton(state),
        );
      },
    );
  }

  Widget buildScanButton(Bluetooth_State state) {
    return FloatingActionButton(
      backgroundColor: state.isScanning ? Colors.red : Colors.blue,
      onPressed: () {
        if (state.isScanning) {
          context.read<BluetoothCubit>().stopScan();
        } else {
          context.read<BluetoothCubit>().startScan();
        }
      },
      child: Text(state.isScanning ? "STOP" : "SCAN"),
    );
  }

  Widget buildDeviceList(Bluetooth_State state) {
    return state.scanResults.isEmpty
        ? const Center(child: Text('No devices found'))
        : ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: state.scanResults.length,
            itemBuilder: (context, index) {
              final result = state.scanResults[index];
              return ListTile(
                title: Text(result.device.platformName.isNotEmpty
                    ? result.device.platformName
                    : "Unnamed Device"),
                trailing: ElevatedButton(
                  onPressed: () {
                    context
                        .read<BluetoothCubit>()
                        .connectToDevice(result.device, context);
                  },
                  child: const Text("Connect"),
                ),
              );
            },
          );
  }
}
