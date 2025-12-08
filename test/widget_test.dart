import 'package:breathingcompanion/viewmodel/theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:breathingcompanion/main.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('App starts and displays audio controls', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeViewModel(),
        child: const MyApp(),
      ),
    );

    // Verify that the audio control buttons are present.
    expect(find.widgetWithText(ElevatedButton, 'Play'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Stop'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Auto-Stop'), findsOneWidget);
  });
}
