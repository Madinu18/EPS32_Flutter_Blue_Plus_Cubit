part of 'widgets.dart';

class DeviceList extends StatelessWidget {
  final Bluetooth_State state;

  const DeviceList({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    if (state is BluetoothDeviceScanResults) {
      final scanResults = (state as BluetoothDeviceScanResults).scanResults;
      
      if (scanResults == null || scanResults.isEmpty) {
        return const Center(child: Text('No device found'));
      }

      return ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: scanResults.length,
        itemBuilder: (context, index) {
          final result = scanResults[index];
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
    } else {
      return const Center(child: Text('No device found'));
    }
  }
}
