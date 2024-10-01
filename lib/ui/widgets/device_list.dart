part of 'widgets.dart';

class DeviceList extends StatelessWidget {
  final List<ScanResult> deviceScanResult;

  const DeviceList({required this.deviceScanResult, super.key});

  @override
  Widget build(BuildContext context) {
    if (deviceScanResult.isEmpty) {
      return const Center(child: Text('No device found'));
    }

    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: deviceScanResult.length,
      itemBuilder: (context, index) {
        final result = deviceScanResult[index];
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
            child: Text(
              "Connect",
              style: TextStyle(
                color: blueColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
