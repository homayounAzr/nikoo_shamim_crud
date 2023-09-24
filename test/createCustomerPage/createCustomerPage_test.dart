import 'package:flutter_test/flutter_test.dart';
import 'package:nikoo_shamim_crud/main.dart';

void main() {

  group('Create Customer Page', () {

    testWidgets('Page contains input fields', (tester) async {

      await tester.pumpWidget(const MyApp());
      await tester.tap(find.text('Create Customer'));
      await tester.pumpAndSettle();

      expect(find.text('First Name'), findsOneWidget);
      expect(find.text('Last Name'), findsOneWidget);
      expect(find.text('Date Of Birth'), findsOneWidget);
      expect(find.text('Phone Number'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Bank Account Number'), findsOneWidget);

    });

  });

}
