import 'package:flutter_test/flutter_test.dart';
import 'package:nikoo_shamim_crud/main.dart';

void main() {

  group('Main Page', () {

    testWidgets('Page contains buttons', (tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.text('Create Customer'), findsOneWidget);
      expect(find.text('Get All Customers'), findsOneWidget);

    });

  });

}