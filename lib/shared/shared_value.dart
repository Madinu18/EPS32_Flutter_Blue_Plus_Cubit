part of 'shared.dart';

//keperluan bluetooth
DateFormat format1 = DateFormat("EEE, dd-MM-yyyy hh:mm a");
DateFormat format2 = DateFormat("dd-MM-yyyy");
DateFormat formatSiSoil = DateFormat('d/M/yyyy HH:mm');

double dataN = 25;
double dataP = 14;
double dataK = 25;
double dataPH = 6.1;
double dataHumidity = 67;
double dataTemperature = 27;
double dataSalinityTanah = 0;

double humidityBox = 48;
double temperatureBox = 25;
double battery = 98;
int gpsStatus = 0;
DateTime tanggalSiSoil = DateTime.now();

//Kebutuhan Server
String deviceID = "";
String serverName = "";
String deviceToken = "";

//kebutuhan Bluetooth
List<ScanResult> listScanResult = [];
Stream<int>? lockDataStreamAutoConnect;
bool autoConnectIsRunning = false;
late StreamSubscription<int> autoConnectDataSubscription;
late StreamSubscription<List<ScanResult>> scanResultStream;
late StreamSubscription<BluetoothConnectionState> checkAutoConnectSisoil;

//Sisoil
BluetoothDevice? deviceSisoil;
BluetoothCharacteristic? uartSisoilCharacteristic;
BluetoothCharacteristic? functionSisoilCharacteristic;

bool connectSisoil = false;
String deviceSisoilId = "";
String deviceSisoilName = "";
String tanggalSisoil = "";
String statusBatterySisoil = "00";

const String servicesUartServices = "6e400001-b5a3-f393-e0a9-e50e24dcca9e";
const String characteristicUart = "6e400003-b5a3-f393-e0a9-e50e24dcca9e";
const String characteristicFunction = "6e400003-b5a3-f393-e0a9-e50e24dcca9f";

//filter history
DateTime startTime = DateTime.now();
DateTime endTime = DateTime.now().subtract(const Duration(days: 1));
