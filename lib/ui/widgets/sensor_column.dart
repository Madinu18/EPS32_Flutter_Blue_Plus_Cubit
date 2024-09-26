part of 'widgets.dart';

class SensorColumn extends StatelessWidget {
  final String title;
  final String imagePath;
  final Function(Map<String, dynamic>) dataBuilder;
  final Stream<List<int>>? tempHumiStream;

  const SensorColumn({
    required this.title,
    required this.imagePath,
    required this.dataBuilder,
    this.tempHumiStream,
    Key? key,
  }) : super(key: key);

  Map<String, dynamic> parseJsonData(String data) {
    try {
      return {
        "temperature": double.parse(
            RegExp(r'"temperature":(\d+)').firstMatch(data)?.group(1) ?? "NaN"),
        "humidity": double.parse(
            RegExp(r'"Humidity":(\d+)').firstMatch(data)?.group(1) ?? "NaN"),
      };
    } catch (e) {
      return {"temperature": "NaN", "humidity": "NaN"};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(imagePath, width: 100, height: 100),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: const TextStyle(fontSize: 16)),
              StreamBuilder<List<int>>(
                stream: tempHumiStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = String.fromCharCodes(snapshot.data!);
                    final decodedData = parseJsonData(data);
                    return dataBuilder(decodedData);
                  } else {
                    return const Text("Loading...");
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
