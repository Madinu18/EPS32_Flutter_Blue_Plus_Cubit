part of 'pages.dart';

class BluetoothOffScreen extends StatefulWidget {
  const BluetoothOffScreen({super.key});

  @override
  BluetoothOffScreenState createState() => BluetoothOffScreenState();
}

class BluetoothOffScreenState extends State<BluetoothOffScreen> {
  StreamSubscription? adapterSubscription;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BluetoothCubit>(context).streamAdapter();
  }

  @override
  void dispose() {
    adapterSubscription?.cancel();
    super.dispose();
  }

  Widget buildBluetoothOffIcon(BuildContext context) {
    return const Icon(
      Icons.bluetooth_disabled,
      size: 200.0,
      color: Colors.white54,
    );
  }

  Widget buildTurnOnButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        child: const Text('TURN ON', style: TextStyle(color: Colors.blue),),
        onPressed: () async {
          try {
            if (Platform.isAndroid) {
              await FlutterBluePlus.turnOn();
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
    return BlocListener<BluetoothCubit, Bluetooth_State>(
      listener: (context, state) {
        if (state is AdapterState) {
          if (state.adapterON) {
            BlocProvider.of<PageCubit>(context).goToBluetoothPage();
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildBluetoothOffIcon(context),
              if (Platform.isAndroid) buildTurnOnButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
