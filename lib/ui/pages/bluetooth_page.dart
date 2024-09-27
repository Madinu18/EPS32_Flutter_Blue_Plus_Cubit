part of 'pages.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    // context.read<BluetoothCubit>().scanDevice();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BluetoothCubit, Bluetooth_State>(
      listener: (context, state) {
        if (state is BluetoothScaning) {
          setState(() {
            isScanning = state.isScanning;
          });
        }
      },
      child: BlocBuilder<BluetoothCubit, Bluetooth_State>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Scanning Bluetooth",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.read<PageCubit>().goToMainPage();
                },
              ),
            ),
            body: DeviceList(state: state),
            floatingActionButton: BluetoothScanButton(isScanning: isScanning),
          );
        },
      ),
    );
  }
}
