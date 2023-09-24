import 'package:flutter_test/flutter_test.dart';
import 'package:nikoo_shamim_crud/main.dart';

Future<void> theAppIsRunning(WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
}
