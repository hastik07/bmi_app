import 'dart:math';
import 'package:dio/dio.dart';

double calculateBmi(int height, int weight) {
  return 703 * (weight / pow(height, 2));
}

Future<double> calculateBMIAsync(Dio dio) async {
  var result = await dio.get('https://jsonkeeper.com/b/AKFA');
  var data = result.data;
  var bmi = calculateBmi(
    data['Sergio Ramos'][0],
    data['Sergio Ramos'][1],
  );
  return bmi;
}
