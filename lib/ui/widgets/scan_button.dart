part of 'widgets.dart';

class BluetoothScanButton extends StatelessWidget {
  final Bluetooth_State state;

  const BluetoothScanButton({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: state.isScanning ? Colors.red : Colors.blue,
      onPressed: () {
        state.isScanning
            ? context.read<BluetoothCubit>().stopScan()
            : context.read<BluetoothCubit>().startScan();
      },
      child: Text(state.isScanning ? "STOP" : "SCAN"),
    );
  }
}
