import 'dart:convert';

import 'package:http/http.dart' as http;

class MlResult {
  final String prediction;
  final double confidence;

  MlResult({
    required this.prediction,
    required this.confidence,
  });
}

class MlService {
  Future<MlResult> predict(
      List<double> features,
      ) async {
    final response = await http.post(
      Uri.parse(
        //'http://127.0.0.1:8000/predict',
        //'http://10.0.2.2:8000/predict', //ip of laptop for emulator
        //'http://192.168.0.189:8000/predict', //ip of laptop when at home
        'http://192.168.43.184:8000/predict', //ip of laptop on phone hotspot
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'features': features,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Prediction failed.',
      );
    }

    final data =
    jsonDecode(response.body);

    return MlResult(
      prediction: data['prediction'],
      confidence:
      (data['confidence'] as num)
          .toDouble(),
    );
  }
}
