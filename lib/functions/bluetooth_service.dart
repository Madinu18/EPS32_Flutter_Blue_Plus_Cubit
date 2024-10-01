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

  Future<bool> reconnectDevice() async {
  StreamSubscription<List<ScanResult>>? subscription;

  bool reconnectToDevice = false;

  MSG.DBG("Starting to reconnect");
  MSG.DBG("Reconnect to device :${connectedDevice?.remoteId.toString()}");

  FlutterBluePlus.startScan(timeout: const Duration(seconds: reconnectTime));

  subscription = FlutterBluePlus.scanResults.listen((results) async {
    for (var result in results) {
      if (result.device.remoteId.toString() == connectedDevice?.remoteId.toString()) {
        
        MSG.DBG("Found Device :${result.device.remoteId.toString()}");
        await FlutterBluePlus.stopScan();
        
        reconnectToDevice = await BluetoothFunction().connectToDevice(result.device);
      
        if (reconnectToDevice) {
          await subscription?.cancel();
          break;
        }
      }
    }
    await FlutterBluePlus.stopScan();
  });

  await Future.delayed(const Duration(seconds: reconnectTime));
  await subscription.cancel();

  return reconnectToDevice;
}
}