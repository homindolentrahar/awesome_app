import 'package:awesome_app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('instrument test on Gallery page', () {
    testWidgets('display list of images', (tester) async {
      await tester.pumpWidget(const Application());
    });
  });
}
