import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ibmi_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group(
    'end-to-end app test',
    () {
      var weightIncrementButton = find.byKey(const Key('weight_plus'));
      var ageIncrementButton = find.byKey(const Key('age_plus'));
      var calculateBMIButton = find.byType(CupertinoButton);

      testWidgets(
        'Given app is ran when height, age data input and calculateBMI button pressed then correct bmi returned',
        (tester) async {
          //Arrange
          app.main();
          //Act
          await tester.pumpAndSettle();
          await tester.tap(weightIncrementButton);
          await tester.pumpAndSettle();
          await tester.tap(ageIncrementButton);
          await tester.pumpAndSettle();
          await tester.tap(calculateBMIButton);
          await tester.pumpAndSettle();
          final resultText = find.text('Normal');
          //Assert
          expect(resultText, findsOneWidget);
        },
      );
    },
  );
}
