// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_your_luck_app/features/data/game_logic_repository_impl.dart';

import 'package:test_your_luck_app/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  const int randomRabbit = 0;
  final List<int> tappedHatNumbers = [];
  final List<int> rabbitNumber = [];

  final LuckWidgetRepositoryImpl luckWidgetRepository =
      LuckWidgetRepositoryImpl();

  final SaveTheRandomRabbitRepositoryImpl saveTheRandomRabbitRepository =
      SaveTheRandomRabbitRepositoryImpl(prefs);

  final LoadTheRandomRabbitRepositoryImpl loadTheRandomRabbitRepository =
      LoadTheRandomRabbitRepositoryImpl(prefs);

  final GameLogicRepositoryImpl gameLogicRepository = GameLogicRepositoryImpl();
  final SaveStateAppRepositoryImpl saveStateAppRepository =
      SaveStateAppRepositoryImpl(prefs);

  final LoadTheRabbitRepositoryImpl loadTheRabbitRepository =
      LoadTheRabbitRepositoryImpl(prefs);

  final SaveTheRabbitRepositoryImpl saveTheRabbitRepository =
      SaveTheRabbitRepositoryImpl(prefs);

  final LoadStateAppRepositoryImpl loadStateAppRepository =
      LoadStateAppRepositoryImpl(prefs);
  final SaveGameStartTimeRepositoryImpl saveGameStartTimeRepository =
      SaveGameStartTimeRepositoryImpl();

  final SaveGameEndTimeRepositoryImpl saveGameEndTimeRepository =
      SaveGameEndTimeRepositoryImpl();

  final LoadGameStartTimeRepositoryImpl loadGameStartTimeRepository =
      LoadGameStartTimeRepositoryImpl(saveGameStartTimeRepository);

  final LoadGameEndTimeRepositoryImpl loadGameEndTimeRepository =
      LoadGameEndTimeRepositoryImpl(saveGameEndTimeRepository);
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      luckWidgetRepository: luckWidgetRepository,
      loadTheRandomRabbitRepository: loadTheRandomRabbitRepository,
      saveTheRandomRabbitRepository: saveTheRandomRabbitRepository,
      gameLogicRepository: gameLogicRepository,
      loadTheRabbitRepository: loadTheRabbitRepository,
      saveTheRabbitRepository: saveTheRabbitRepository,
      saveStateAppRepository: saveStateAppRepository,
      loadStateAppRepository: loadStateAppRepository,
      generateWidgetsRepository: GenerateWidgetsRepositoryImpl(
        prefs,
        tappedHatNumbers,
        saveStateAppRepository,
        rabbitNumber,
        saveTheRabbitRepository,
        saveTheRandomRabbitRepository,
        randomRabbit,
      ),
      saveGameStartTimeRepository: saveGameStartTimeRepository,
      loadGameStartTimeRepository: loadGameStartTimeRepository,
      loadGameEndTimeRepository: loadGameEndTimeRepository,
      saveGameEndTimeRepository: saveGameEndTimeRepository,
    ));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
