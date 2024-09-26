part of "models.dart";

class SensorData {
  final double temperature;
  final double humidity;

  SensorData({required this.temperature, required this.humidity});

  factory SensorData.fromJson(String data) {
    try {
      final temp = double.parse(
          RegExp(r'"temperature":(\d+)').firstMatch(data)?.group(1) ?? "NaN");
      final hum = double.parse(
          RegExp(r'"humidity":(\d+)').firstMatch(data)?.group(1) ?? "NaN");
      return SensorData(temperature: temp, humidity: hum);
    } catch (e) {
      return SensorData(temperature: double.nan, humidity: double.nan);
    }
  }
}
