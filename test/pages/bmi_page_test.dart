import 'package:flutter_test/flutter_test.dart';
import 'package:ibmi_app/pages/bmi_page.dart';
import 'package:flutter/cupertino.dart';

void main() {
  testWidgets(
    'Given weight info card user on BMI Page when user click + button then wait increment by one',
    (tester) async {
      //Arrange
      await tester.pumpWidget(
        const CupertinoApp(
          home: BmiPage(),
        ),
      );
      var weightIncrementButton = find.byKey(
        const Key('weight plus'),
      );
      //Act
      await tester.tap(weightIncrementButton);
      await tester.pump();
      //Assert
      var text = find.text('161');
      expect(text, findsOneWidget);
    },
  );

  testWidgets(
    'Given weight info card user on BMI Page when user click - button then wait decrement by one',
        (tester) async {
      //Arrange
      await tester.pumpWidget(
        const CupertinoApp(
          home: BmiPage(),
        ),
      );
      var weightIncrementButton = find.byKey(
        const Key('weight minus'),
      );
      //Act
      await tester.tap(weightIncrementButton);
      await tester.pump();
      //Assert
      var text = find.text('159');
      expect(text, findsOneWidget);
    },
  );
}
