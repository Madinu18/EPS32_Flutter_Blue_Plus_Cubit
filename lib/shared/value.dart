part of 'shared.dart';

BluetoothCharacteristic? bluetoothChar;
BluetoothDevice? connectedDevice;
Stream<List<int>>? tempHumiValue;
bool connectedToDevice = false;

//controllable variable
const int scanTimeinSecond = 5;