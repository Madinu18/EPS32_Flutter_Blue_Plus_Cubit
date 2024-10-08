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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothCubit, Bluetooth_State>(
      builder: (context, state) {
        // Periksa status Bluetooth hanya di BluetoothPage
        if (state.adapterBluetooth == BluetoothAdapterState.on) {
          // Jika Bluetooth menyala, navigasi ke BluetoothPage
          context.read<PageCubit>().goToBluetoothPage();
        } else {
          // Jika Bluetooth mati, navigasi ke BluetoothOffScreen
          context.read<PageCubit>().goToBluetoothOffScreen();
        }

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
          floatingActionButton: BluetoothScanButton(state: state),
        );
      },
    );
  }
}
