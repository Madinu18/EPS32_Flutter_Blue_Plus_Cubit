part of 'bluetooth_cubit.dart';

@immutable
abstract class Bluetooth_State {}

class BluetoothStateInitial extends Bluetooth_State {}

class BluetoothLoading extends Bluetooth_State {}

class BluetoothScaning extends Bluetooth_State {
  final bool isScanning;

  BluetoothScaning(this.isScanning);

  List<Object> get props => [isScanning];
}

class BluetoothDeviceScanResults extends Bluetooth_State {
  final List<ScanResult>? scanResults;

  BluetoothDeviceScanResults(this.scanResults);

  List<Object> get props => [scanResults ?? []];
}

class Connected extends Bluetooth_State {
  final bool status;

  Connected(this.status);

  List<Object> get props => [status];
}

class BluetoothDisconnectDialog extends Bluetooth_State {}

class AdapterState extends Bluetooth_State {
  final bool adapterON;

  AdapterState(this.adapterON);
  
  List<Object>  get props => [adapterON];
}
