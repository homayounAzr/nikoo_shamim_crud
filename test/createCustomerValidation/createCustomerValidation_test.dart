import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nikoo_shamim_crud/main.dart';

void main() {
  group('create Customer Form', () {
    testWidgets('InValid submission', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.tap(find.text('Create Customer'));
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextField, 'First Name'), 'Homayoun');
      await tester.enterText(find.widgetWithText(TextField, 'Last Name'), 'Azarnia');
      await tester.enterText(find.widgetWithText(DateTimeField, 'Date Of Birth'), '2023-09-24');
      await tester.enterText(find.widgetWithText(TextField, 'Phone Number'), '0');
      await tester.enterText(find.widgetWithText(TextField, 'Email'), 'homayoun.azarnia');
      await tester.enterText(find.widgetWithText(TextField, 'Bank Account Number'), '6037831055114069');

      await tester.ensureVisible(find.text('Create Customer'));

      await tester.tap(find.text('Create Customer'));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Create Customer Page'), findsOneWidget);
    });
  });
}

