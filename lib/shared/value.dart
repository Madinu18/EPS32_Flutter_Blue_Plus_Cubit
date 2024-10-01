part of 'shared.dart';

BluetoothCharacteristic? bluetoothChar;
BluetoothDevice? connectedDevice;
Stream<List<int>>? tempHumiValue;
bool connectedToDevice = false;

StreamSubscription<BluetoothAdapterState>? adapterSubscription;

//controllable variable
const int scanTimeinSecond = 5;
const int reconnectTime = 10;