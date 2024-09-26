part of 'functions.dart';

void initBluetoothConnectionStream(
    BuildContext context,
    Function(StreamSubscription<BluetoothConnectionState>?)
        onUpdateSubscription) {
  final bluetoothCubit = BlocProvider.of<BluetoothCubit>(context);
  StreamSubscription<BluetoothConnectionState>? connectionSubscription;

  if (bluetoothCubit.state.connectedDevice != null) {
    connectionSubscription = bluetoothCubit
        .state.connectedDevice!.connectionState
        .listen((BluetoothConnectionState state) {
      if (state == BluetoothConnectionState.disconnected) {
        bluetoothCubit.disconnectDevice();
        if (context.mounted) {
          showDisconnectDialog(
            context,
            bluetoothCubit.disconnectDevice,
          );
        }
      }
    });
  }
  onUpdateSubscription(connectionSubscription);
}

// void initBluetoothAdapterStateStream(BuildContext context, Function(StreamSubscription<BluetoothAdapterState>?) onUpdateSubscription){
//   final bluetoothCubit = BlocProvider.of<BluetoothCubit>(context);
//   StreamSubscription<BluetoothAdapterState>? adapterSubsciption;

//   adapterSubsciption = bluetoothCubit.state.isBluetoothON
// }