import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../functions/functions.dart';
import '../shared/shared.dart';

part 'bluetooth_state.dart';

class BluetoothCubit extends Cubit<Bluetooth_State> {
  BluetoothCubit() : super(BluetoothStateInitial());

  StreamSubscription<BluetoothConnectionState>? connectionSubscription;

  StreamSubscription<List<ScanResult>>? subscription;
  StreamSubscription<bool>? _isScanningSubscription;

  List<ScanResult> _scanResults = [];

  Future<void> connectToDevice(
      BluetoothDevice device, BuildContext context) async {
    emit(BluetoothLoading());
    try {
      connectedToDevice = await BluetoothFunction().connectToDevice(device);
      if (connectedToDevice) {
        await bluetoothChar?.setNotifyValue(true);
        connectedDevice = device;
        tempHumiValue = bluetoothChar?.onValueReceived;
        streamConnection();
        emit(Connected(true));
      }
    } catch (e) {
      MSG.ERR("Error: $e");
      emit(Connected(false));
    }
  }

  void streamConnection() {
    connectionSubscription = connectedDevice!.connectionState
        .listen((BluetoothConnectionState state) {
      if (state == BluetoothConnectionState.disconnected) {
        MSG.DBG("disconect dari ble");
        emit(BluetoothDisconnectDialog());
        bluetoothChar?.setNotifyValue(false);
        // emit(Connected(false));
      }
    });
  }

  Future<void> disconnectDevice(BluetoothDevice device) async {
    try {
      await connectionSubscription?.cancel();
      await BluetoothFunction().disconnectDevice(device);
      emit(Connected(false));
    } catch (e) {
      MSG.ERR("Disconect Failed Error: $e");
    }
  }

  Future<void> scanDevice() async {
    try {
      MSG.DBG("Start scanning");

      await FlutterBluePlus.startScan(
        timeout: const Duration(seconds: scanTimeinSecond));
      subscription = FlutterBluePlus.scanResults.listen((results) {
        _scanResults = results;
        emit(BluetoothDeviceScanResults(_scanResults));
      });
      _isScanningSubscription = FlutterBluePlus.isScanning.listen((isScanning) {
        emit(BluetoothScaning(isScanning));
        MSG.DBG(isScanning.toString());
      });

      await Future.delayed(const Duration(seconds: scanTimeinSecond));
    } catch (e) {
      MSG.ERR("Error during scan: $e");
      emit(BluetoothScaning(false));
    }
  }

  Future<void> stopScanDevice() async {
    try {
      await FlutterBluePlus.stopScan();
      subscription?.cancel();
      _isScanningSubscription?.cancel();
      emit(BluetoothScaning(false));
      MSG.DBG("Scanning stopped");
    } catch (e) {
      MSG.ERR("Stop Scan Error: $e");
    }
  }

  Future<void> streamAdapter() async {
   adapterSubscription = FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
    if (state == BluetoothAdapterState.on) {
        emit(AdapterState(true));
    } else {
        emit(AdapterState(false));
    }
});
  }
}
