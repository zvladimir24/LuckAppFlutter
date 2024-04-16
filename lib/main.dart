import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_your_luck_app/bloc/game_bloc/game_bloc_bloc.dart';
import 'package:test_your_luck_app/features/data/game_logic_repository_impl.dart';
import 'package:test_your_luck_app/features/domain/game_logic_repository.dart';
import 'package:test_your_luck_app/features/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  const int randomRabbit = 0;

  final List<int> rabbitNumber = [];

  final List<int> tappedHatNumbers = [];

  final LuckWidgetRepositoryImpl luckWidgetRepository =
      LuckWidgetRepositoryImpl();

  final SaveTheRandomRabbitRepositoryImpl saveTheRandomRabbitRepository =
      SaveTheRandomRabbitRepositoryImpl(prefs);

  final LoadTheRandomRabbitRepositoryImpl loadTheRandomRabbitRepository =
      LoadTheRandomRabbitRepositoryImpl(prefs);

  final GameLogicRepositoryImpl gameLogicRepository = GameLogicRepositoryImpl();

  final SaveTheRabbitRepositoryImpl saveTheRabbitRepository =
      SaveTheRabbitRepositoryImpl(prefs);

  final SaveStateAppRepositoryImpl saveStateAppRepository =
      SaveStateAppRepositoryImpl(prefs);

  final LoadTheRabbitRepositoryImpl loadTheRabbitRepository =
      LoadTheRabbitRepositoryImpl(prefs);

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

  final GenerateWidgetsRepository generateWidgetsRepository =
      GenerateWidgetsRepositoryImpl(
    prefs,
    tappedHatNumbers,
    saveStateAppRepository,
    rabbitNumber,
    saveTheRabbitRepository,
    saveTheRandomRabbitRepository,
    randomRabbit,
  );

  runApp(MyApp(
    luckWidgetRepository: luckWidgetRepository,
    loadTheRandomRabbitRepository: loadTheRandomRabbitRepository,
    saveTheRandomRabbitRepository: saveTheRandomRabbitRepository,
    gameLogicRepository: gameLogicRepository,
    loadTheRabbitRepository: loadTheRabbitRepository,
    saveTheRabbitRepository: saveTheRabbitRepository,
    saveStateAppRepository: saveStateAppRepository,
    loadStateAppRepository: loadStateAppRepository,
    generateWidgetsRepository: generateWidgetsRepository,
    saveGameStartTimeRepository: saveGameStartTimeRepository,
    saveGameEndTimeRepository: saveGameEndTimeRepository,
    loadGameStartTimeRepository: loadGameStartTimeRepository,
    loadGameEndTimeRepository: loadGameEndTimeRepository,
  ));
}

class MyApp extends StatelessWidget {
  final LuckWidgetRepository luckWidgetRepository;
  final LoadTheRandomRabbitRepository loadTheRandomRabbitRepository;
  final SaveTheRandomRabbitRepository saveTheRandomRabbitRepository;
  final GameLogicRepository gameLogicRepository;
  final LoadTheRabbitRepository loadTheRabbitRepository;
  final SaveTheRabbitRepository saveTheRabbitRepository;
  final SaveStateAppRepository saveStateAppRepository;
  final LoadStateAppRepository loadStateAppRepository;
  final GenerateWidgetsRepository generateWidgetsRepository;
  final SaveGameStartTimeRepository saveGameStartTimeRepository;
  final SaveGameEndTimeRepository saveGameEndTimeRepository;
  final LoadGameStartTimeRepository loadGameStartTimeRepository;
  final LoadGameEndTimeRepository loadGameEndTimeRepository;

  const MyApp({
    Key? key,
    required this.luckWidgetRepository,
    required this.loadTheRandomRabbitRepository,
    required this.saveTheRandomRabbitRepository,
    required this.gameLogicRepository,
    required this.loadTheRabbitRepository,
    required this.saveTheRabbitRepository,
    required this.generateWidgetsRepository,
    required this.saveGameStartTimeRepository,
    required this.saveGameEndTimeRepository,
    required this.loadGameStartTimeRepository,
    required this.loadGameEndTimeRepository,
    required this.loadStateAppRepository,
    required this.saveStateAppRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(
        saveStateAppRepository,
        loadTheRandomRabbitRepository,
        loadStateAppRepository,
        loadTheRabbitRepository,
        saveTheRabbitRepository,
        GameLogicRepositoryImpl(),
        saveGameStartTimeRepository,
        saveGameEndTimeRepository,
        loadGameStartTimeRepository,
        loadGameEndTimeRepository,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TestYourLuck',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage(
          luckWidgetRepository: luckWidgetRepository,
          loadTheRandomRabbitRepository: loadTheRandomRabbitRepository,
          saveTheRandomRabbitRepository: saveTheRandomRabbitRepository,
          saveTheRabbitRepository: saveTheRabbitRepository,
          gameLogicRepository: gameLogicRepository,
          loadTheRabbitRepository: loadTheRabbitRepository,
          saveGameEndTimeRepository: saveGameEndTimeRepository,
          generateWidgetsRepository: generateWidgetsRepository,
          saveGameStartTimeRepository: saveGameStartTimeRepository,
          saveStateAppRepository: saveStateAppRepository,
          loadGameEndTimeRepository: loadGameEndTimeRepository,
          loadGameStartTimeRepository: loadGameStartTimeRepository,
          loadStateAppRepository: loadStateAppRepository,
        ),
      ),
    );
  }
}
