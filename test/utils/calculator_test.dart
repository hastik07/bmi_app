import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibmi_app/utils/calculator.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

void main() {
  test(
      'Give height and weight When calculateBMI function invoked Then correct BMI returned',
      () {
    //Arrange
    const int height = 70, weight = 160;
    //Act
    double bmi = calculateBmi(height, weight);
    //Assert
    expect(bmi, 22.955102040816328);
  });

  test('Give an URL when calculateBMIAsync invoked Then correct BMI returned',
      () async {
    //Arrange
    final dioMock = DioMock();
    when(() => dioMock.get('https://jsonkeeper.com/b/AKFA')).thenAnswer(
      (_) => Future.value(
        Response(
          requestOptions: RequestOptions(path: 'https://jsonkeeper.com/b/AKFA'),
          data:
            {
              'Sergio Ramos': [72, 165],
            },
        ),
      ),
    );
    //Act
    var result = await calculateBMIAsync(dioMock);
    //Assert
        expect(result, 22.375578703703706);
  });
}
