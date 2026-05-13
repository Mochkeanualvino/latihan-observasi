import 'package:flutter_test/flutter_test.dart';
import 'package:edutrack_plus/main.dart';

void main() {
  testWidgets('EduTrack+ app starts', (WidgetTester tester) async {
    await tester.pumpWidget(const EduTrackApp());
    await tester.pump(const Duration(seconds: 5));
    expect(find.text('EduTrack+'), findsWidgets);
  });
}
