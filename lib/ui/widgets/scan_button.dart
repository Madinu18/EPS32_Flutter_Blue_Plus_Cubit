part of 'widgets.dart';

class BluetoothScanButton extends StatelessWidget {
  final bool isScanning;

  const BluetoothScanButton({required this.isScanning, super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: isScanning ? Colors.red : Colors.blue,
      onPressed: () {
        isScanning
            ? context.read<BluetoothCubit>().stopScanDevice()
            : context.read<BluetoothCubit>().scanDevice();
      },
      child: Text(isScanning ? "STOP" : "SCAN"),
    );
  }
}
