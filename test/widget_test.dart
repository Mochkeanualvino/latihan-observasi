import 'package:flutter_test/flutter_test.dart';
import 'package:edutrack_plus/main.dart';

void main() {
  testWidgets('EduTrack+ app starts', (WidgetTester tester) async {
    await tester.pumpWidget(const EduTrackApp());
    expect(find.text('EduTrack+'), findsOneWidget);
  });
}
