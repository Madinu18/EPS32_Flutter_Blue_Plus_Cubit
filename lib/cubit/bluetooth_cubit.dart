import 'package:flutter_application_1/cubit/page_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';

part 'bluetooth_state.dart';

class BluetoothCubit extends Cubit<Bluetooth_State> {
  BluetoothCubit()
      : super(const Bluetooth_State(
          isBluetoothON: BluetoothAdapterState.unknown,
          isScanning: false,
          isConnected: false,
          scanResults: [],
          systemDevices: [],
        ));

  StreamSubscription<List<ScanResult>>? _scanResultsSubscription;
  StreamSubscription<bool>? _isScanningSubscription;
  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;

  Future<void> startScan() async {
    emit(state.copyWith(isScanning: true));

    try {
      //Listen to bluetooth adapter state
      _adapterStateSubscription =
          FlutterBluePlus.adapterState.listen((isBluetoothON) {
        emit(state.copyWith(isBluetoothON: isBluetoothON));
      });

      // Listen to system devices
      List<BluetoothDevice> systemDevices = await FlutterBluePlus.systemDevices;
      emit(state.copyWith(systemDevices: systemDevices));

      // Listen to scan results
      _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
        emit(state.copyWith(scanResults: results));
      });

      // Listen to isScanning state
      _isScanningSubscription = FlutterBluePlus.isScanning.listen((isScanning) {
        emit(state.copyWith(isScanning: isScanning));
      });

      // Start scan
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    } catch (e) {
      // Handle error
      print("Error: $e");
      stopScan();
    }
  }

  Future<void> stopScan() async {
    try {
      await FlutterBluePlus.stopScan();
      emit(state.copyWith(isScanning: false));
    } catch (e) {
      print("Stop Scan Error: $e");
    }
  }

  Future<void> connectToDevice(
      BluetoothDevice device, BuildContext context) async {
    try {
      // Menghubungkan perangkat
      await device.connect();

      // Menemukan semua layanan dari perangkat
      List<BluetoothService> services = await device.discoverServices();

      // Emit state baru dengan perangkat terhubung dan daftar layanan
      emit(state.copyWith(connectedDevice: device, services: services));

      // Loop melalui layanan untuk menemukan karakteristik yang cocok
      for (var service in services) {
        for (var char in service.characteristics) {
          // Jika karakteristik sesuai dengan UUID yang diinginkan
          if (char.uuid.toString() == "beb5483e-36e1-4688-b7f5-ea07361b26a8") {
            // Mengaktifkan notifikasi pada karakteristik
            await char.setNotifyValue(true);

            // Membuat stream dari karakteristik
            Stream<List<int>> tempHumiStream = char.onValueReceived;

            // Pindah ke halaman utama (jika diperlukan)
            BlocProvider.of<PageCubit>(context).goToMainPage();

            // Emit state baru dengan status terhubung, karakteristik, dan stream
            emit(state.copyWith(
              isConnected: true,
              characteristic: char,
              tempHumiStream: tempHumiStream,
            ));
          }
        }
      }
    } catch (e) {
      print("Connect Error: $e");
    }
  }

  Future<void> disconnectDevice() async {
    if (state.connectedDevice != null) {
      try {
        await state.connectedDevice!.disconnect();
        emit(state.copyWith(isConnected: false, connectedDevice: null));
      } catch (e) {
        print("Failed to disconnect: $e");
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
