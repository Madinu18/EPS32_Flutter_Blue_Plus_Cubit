part of 'bluetooth_cubit.dart';

@immutable
class Bluetooth_State {
  final BluetoothAdapterState isBluetoothON;
  final bool isScanning;
  final bool isConnected;
  final List<BluetoothDevice> systemDevices;
  final List<ScanResult> scanResults;
  final BluetoothDevice? connectedDevice;
  final List<BluetoothService>? services;
  final Stream<List<int>>? tempHumiStream;
  final BluetoothCharacteristic? characteristic;

  const Bluetooth_State({
    required this.isBluetoothON,
    required this.isScanning,
    required this.isConnected,
    required this.systemDevices,
    required this.scanResults,
    this.connectedDevice,
    this.services,
    this.tempHumiStream,
    this.characteristic,
  });

  Bluetooth_State copyWith({
    BluetoothAdapterState? isBluetoothON,
    bool? isScanning,
    bool? isConnected,
    List<BluetoothDevice>? systemDevices,
    List<ScanResult>? scanResults,
    BluetoothDevice? connectedDevice,
    List<BluetoothService>? services,
    Stream<List<int>>? tempHumiStream,
    BluetoothCharacteristic? characteristic,
  }) {
    return Bluetooth_State(
      isBluetoothON: isBluetoothON ?? this.isBluetoothON,
      isScanning: isScanning ?? this.isScanning,
      isConnected: isConnected ?? this.isConnected,
      systemDevices: systemDevices ?? this.systemDevices,
      scanResults: scanResults ?? this.scanResults,
      connectedDevice: connectedDevice ?? this.connectedDevice,
      services: services ?? this.services,
      tempHumiStream: tempHumiStream ?? this.tempHumiStream,
      characteristic: characteristic ?? this.characteristic,
    );
  }
}
