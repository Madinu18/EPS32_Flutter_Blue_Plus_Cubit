import 'package:flutter_application_1/cubit/page_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';
import '../utils/logger.dart';

part 'bluetooth_state.dart';

class BluetoothCubit extends Cubit<Bluetooth_State> {
  BluetoothCubit()
      : super(const Bluetooth_State(
          adapterBluetooth: BluetoothAdapterState.unknown,
          isScanning: false,
          isConnected: false,
          scanResults: [],
          systemDevices: [],
        )) {
    _adapterStateSubscription =
        FlutterBluePlus.adapterState.listen((adapterState) {
      emit(state.copyWith(adapterBluetooth: adapterState));
      MSG.DBG("Adapter State Changed: $adapterState");
    });
  }

  StreamSubscription<List<ScanResult>>? _scanResultsSubscription;
  StreamSubscription<bool>? _isScanningSubscription;
  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;
  StreamSubscription<BluetoothConnectionState>? connectionSubscription;

  Future<void> startScan() async {
    emit(state.copyWith(isScanning: true));

    try {
      List<BluetoothDevice> systemDevices = await FlutterBluePlus.systemDevices;
      emit(state.copyWith(systemDevices: systemDevices));

      _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
        emit(state.copyWith(scanResults: results));
      });

      _isScanningSubscription = FlutterBluePlus.isScanning.listen((isScanning) {
        emit(state.copyWith(isScanning: isScanning));
      });

      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    } catch (e) {
      MSG.ERR("Error: $e");
      stopScan();
    }
  }

  Future<void> stopScan() async {
    try {
      await FlutterBluePlus.stopScan();
      emit(state.copyWith(isScanning: false));
    } catch (e) {
      MSG.ERR("Stop Scan Error: $e");
    }
  }

  Future<void> connectToDevice(
      BluetoothDevice device, BuildContext context) async {
    try {
      await device.connect();

      List<BluetoothService> services = await device.discoverServices();

      emit(state.copyWith(connectedDevice: device, services: services));

      for (var service in services) {
        for (var char in service.characteristics) {
          if (char.uuid.toString() == "beb5483e-36e1-4688-b7f5-ea07361b26a8") {
            await char.setNotifyValue(true);

            Stream<List<int>> tempHumiStream = char.onValueReceived;

            if (context.mounted) {
              BlocProvider.of<PageCubit>(context).goToMainPage();
            }

            emit(state.copyWith(
              isConnected: true,
              characteristic: char,
              tempHumiStream: tempHumiStream,
            ));
          }
        }
      }
    } catch (e) {
      MSG.ERR("Connect Error: $e");
    }
  }

  Future<void> disconnectDevice() async {
    if (state.connectedDevice != null) {
      try {
        await state.connectedDevice!.disconnect();
        emit(state.copyWith(isConnected: false, connectedDevice: null));
      } catch (e) {
        MSG.ERR("Failed to disconnect: $e");
      }
    }
  }

  @override
  Future<void> close() {
    _adapterStateSubscription?.cancel();
    _scanResultsSubscription?.cancel();
    _isScanningSubscription?.cancel();
    return super.close();
  }
}
