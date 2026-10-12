import 'package:flutter_test/flutter_test.dart';
import 'package:pinterest_clone/main.dart';

void main() {
  testWidgets('splash shows Arstora, then opens Home', (tester) async {
    await tester.pumpWidget(const PinterestCloneApp());
    expect(find.text('Arstora'), findsOneWidget);
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
    expect(find.text('Arstora'), findsOneWidget);
  });
}
