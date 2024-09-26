part of 'widgets.dart';

class BluetoothConnectButton extends StatelessWidget {
  final VoidCallback onDisconnect;

  const BluetoothConnectButton({required this.onDisconnect, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothCubit, Bluetooth_State>(
        builder: (context, state) {
      return SizedBox(
        width: 200.0,
        height: 60.0,
        child: FloatingActionButton(
          onPressed: () async {
            if (state.isBluetoothON != BluetoothAdapterState.on) {
              onDisconnect();
              //context.read<PageCubit>().goToBluetoothPage();
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
}

class BluetoothDisconnectButton extends StatelessWidget {
  final VoidCallback onConnect;

  const BluetoothDisconnectButton({required this.onConnect, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 60.0,
      child: FloatingActionButton(
        onPressed: onConnect,
        backgroundColor: Colors.red,
        tooltip: 'Disconect from device',
        child: const Icon(Icons.bluetooth_disabled),
      ),
    );
  }
}
