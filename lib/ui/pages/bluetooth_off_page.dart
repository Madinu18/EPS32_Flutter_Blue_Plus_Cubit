part of 'pages.dart';

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({super.key});

  Widget buildBluetoothOffIcon(BuildContext context) {
    return const Icon(
      Icons.bluetooth_disabled,
      size: 200.0,
      color: Colors.white54,
    );
  }

  Widget buildTitle(BuildContext context, BluetoothAdapterState adapterState) {
    String state = adapterState.toString().split(".").last;
    return Text(
      'Bluetooth Adapter is $state',
      style: Theme.of(context)
          .primaryTextTheme
          .titleSmall
          ?.copyWith(color: Colors.white),
    );
  }

  Widget buildTurnOnButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        child: const Text('TURN ON'),
        onPressed: () async {
          try {
            if (Platform.isAndroid) {
              await FlutterBluePlus.turnOn();
              BlocProvider.of<PageCubit>(context).goToBluetoothPage();
            }
          } catch (e) {
            MSG.ERR("Error Turning On: $e");
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final adapterState =
        context.read<BluetoothCubit>().adapterState; // Ambil adapter state

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            buildBluetoothOffIcon(context),
            buildTitle(context, adapterState), // Pass adapterState
            if (Platform.isAndroid) buildTurnOnButton(context),
          ],
        ),
      ),
    );
  }
}
