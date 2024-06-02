import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lob_app/pages/game_keeper.dart';

void main() {
  testWidgets('GameKeeperPage has a title', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GameKeeperPage()));

    // Check if the AppBar title is present
    expect(find.text('Basketball Score Keeper'), findsOneWidget);
  });

  testWidgets('Team names input fields are present',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GameKeeperPage()));

    // Check if the input fields for team names are present
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Team 1 Name'), findsOneWidget);
    expect(find.text('Team 2 Name'), findsOneWidget);
  });

  testWidgets('Score buttons increment and decrement the scores',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GameKeeperPage()));

    // Set default team names
    await tester.enterText(find.byType(TextField).first, 'Team 1');
    await tester.enterText(find.byType(TextField).last, 'Team 2');
    await tester.pump(); // Rebuild the widget with new team names

    // Increment team 1 score
    await tester.tap(find.text('+1').first);
    await tester.pump();
    expect(find.text('Team 1: 1'), findsOneWidget);

    // Decrement team 1 score
    await tester.tap(find.text('-1').first);
    await tester.pump();
    expect(find.text('Team 1: 0'), findsOneWidget);

    // Increment team 2 score
    await tester.tap(find.text('+1').last);
    await tester.pump();
    expect(find.text('Team 2: 1'), findsOneWidget);

    // Decrement team 2 score
    await tester.tap(find.text('-1').last);
    await tester.pump();
    expect(find.text('Team 2: 0'), findsOneWidget);
  });

  testWidgets('Timers start and pause correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GameKeeperPage()));

    // Start the timers
    expect(find.text('Start'), findsOneWidget);
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    expect(find.text('Pause'), findsOneWidget);

    // Pause the timers
    await tester.tap(find.text('Pause'));
    await tester.pumpAndSettle();
    expect(find.text('Start'), findsOneWidget);
  });
}
