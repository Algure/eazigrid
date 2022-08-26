import 'package:flutter_test/flutter_test.dart';

import 'test_screen_widget.dart';

void main() {
  testWidgets('Widget tests', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    int totalItems = 30;
    try {
      await tester.pumpWidget( MyTestApp(totalItems: totalItems,), Duration(seconds: 8));
    }catch(e,t){
      print('error: $e, trace: $t');
    }

    for(int i=0; i<totalItems; i++) {
      expect(find.text('test item: $i'), findsOneWidget);
    }
  });
}

// TODO: Write documentation for each file
// TODO: Test with Pana.



