part of 'functions.dart';

String uuidDevice = "beb5483e-36e1-4688-b7f5-ea07361b26a8";

class BluetoothFunction {
  

  Future<bool> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      List<BluetoothService> services = await device.discoverServices();
      for (var service in services) {
        for (var char in service.characteristics) {
          if (char.uuid.toString() == uuidDevice) {
            connectedDevice = device;
            bluetoothChar = char;
            return true;
          }
        }
      }
      MSG.ERR("This Device is not the product");
      return false;
    } catch (e) {
      MSG.ERR("Connect Error: $e");
      return false;
    }
  }

  Future<void> disconnectDevice(BluetoothDevice device) async {
    try {
      await device.disconnect();
    } catch (e) {
      MSG.ERR("Failed to disconnect: $e");
    }
  }
}

// void initBluetoothConnectionStream(
//     BuildContext context,
//     Function(StreamSubscription<BluetoothConnectionState>?)
//         onUpdateSubscription) {
//   final bluetoothCubit = BlocProvider.of<BluetoothCubit>(context);
//   StreamSubscription<BluetoothConnectionState>? connectionSubscription;

//   if (bluetoothCubit.state.connectedDevice != null) {
//     connectionSubscription = bluetoothCubit
//         .state.connectedDevice!.connectionState
//         .listen((BluetoothConnectionState state) {
//       if (state == BluetoothConnectionState.disconnected) {
//         bluetoothCubit.disconnectDevice();
//         if (context.mounted) {
//           showDisconnectDialog(
//             context,
//           );
//         }
//       }
//     });
//   }
//   onUpdateSubscription(connectionSubscription);
// }

// void initBluetoothAdapterStateStream(BuildContext context,
//     Function(StreamSubscription<BluetoothAdapterState>?) onUpdateSubscription) {
//   final bluetoothCubit = BlocProvider.of<BluetoothCubit>(context);
//   StreamSubscription<BluetoothAdapterState>? adapterStateSubscription;

  
//   adapterStateSubscription =
//       bluetoothCubit.state.adapterBluetooth.listen((BluetoothAdapterState adapterState) {
//         if (adapterState == BluetoothAdapterState.on){

//         }
//   });
//   onUpdateSubscription(adapterStateSubscription);
// }