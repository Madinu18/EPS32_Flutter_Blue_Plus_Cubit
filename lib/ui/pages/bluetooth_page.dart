part of 'pages.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  bool isScanning = false;
  List<ScanResult> deviceScanResult = [];

  @override
  void initState() {
    BlocProvider.of<BluetoothCubit>(context).streamAdapter();
    super.initState();
    // context.read<BluetoothCubit>().scanDevice();
  }

  @override
  void dispose() {
    adapterSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BluetoothCubit, Bluetooth_State>(
      listener: (context, state) {
        if (state is AdapterState){
          setState(() {
            if(!state.adapterON){
              BlocProvider.of<PageCubit>(context).goToBluetoothOffScreen();
            }
          });
        }

        if (state is BluetoothScaning) {
          setState(() {
            isScanning = state.isScanning;
          });
        }

        if (state is BluetoothDeviceScanResults) {
          setState(() {
            deviceScanResult = state.scanResults!;
          });
        }

        if (state is BluetoothLoading) {
          showLoadingPopup(context);
          Future.delayed(const Duration(seconds: 4));
        }

        if (state is Connected) {
          setState(() {
            if (state.status == true) {
              Navigator.of(context).pop();
              context.read<PageCubit>().goToMainPage();
            } else {
              showFailedToConnectDialog(context);
            }
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
            body: DeviceList(deviceScanResult: deviceScanResult),
            floatingActionButton: BluetoothScanButton(isScanning: isScanning),
          );
        },
      ),
    );
  }
}
