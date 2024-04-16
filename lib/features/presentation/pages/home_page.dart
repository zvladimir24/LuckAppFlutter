import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_your_luck_app/bloc/game_bloc/game_bloc_bloc.dart';
import 'package:test_your_luck_app/features/data/game_logic_repository_impl.dart';
import 'package:test_your_luck_app/features/domain/game_logic_repository.dart';

class HomePage extends StatelessWidget {
  final LuckWidgetRepository luckWidgetRepository;
  final SaveTheRandomRabbitRepository saveTheRandomRabbitRepository;
  final LoadTheRandomRabbitRepository loadTheRandomRabbitRepository;
  final SaveTheRabbitRepository saveTheRabbitRepository;
  final GameLogicRepository gameLogicRepository;
  final LoadTheRabbitRepository loadTheRabbitRepository;
  final GenerateWidgetsRepository generateWidgetsRepository;
  final SaveGameEndTimeRepository saveGameEndTimeRepository;
  final SaveGameStartTimeRepository saveGameStartTimeRepository;
  final SaveStateAppRepository saveStateAppRepository;
  final LoadGameEndTimeRepository loadGameEndTimeRepository;
  final LoadGameStartTimeRepository loadGameStartTimeRepository;
  final LoadStateAppRepository loadStateAppRepository;

  const HomePage({
    super.key,
    required this.luckWidgetRepository,
    required this.saveTheRandomRabbitRepository,
    required this.loadTheRandomRabbitRepository,
    required this.saveTheRabbitRepository,
    required this.gameLogicRepository,
    required this.loadTheRabbitRepository,
    required this.generateWidgetsRepository,
    required this.loadGameEndTimeRepository,
    required this.loadGameStartTimeRepository,
    required this.saveGameStartTimeRepository,
    required this.saveStateAppRepository,
    required this.saveGameEndTimeRepository,
    required this.loadStateAppRepository,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GameBloc, GameBlocState>(
        builder: (context, state) {
          if (state is GameBlocInitial) {
            saveGameStartTimeRepository.saveGameStartTime();

            return FutureBuilder<List<dynamic>>(
              future: Future.wait([
                loadGameEndTimeRepository.loadGameEndTime(),
                loadTheRandomRabbitRepository.loadTheRandomRabbit(),
                loadStateAppRepository.loadStateApp(),
                loadTheRabbitRepository.loadTheRabbit(),
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final endTime = snapshot.data?[0];
                  final difference = DateTime.now().difference(
                      DateTime.fromMillisecondsSinceEpoch(endTime ?? 0));
                  final List<dynamic> data = snapshot.data ?? [];
                  final rabbitNumber = data.length > 1 ? data[3] : [];
                  final tappedHatNumbers = data.length > 2 ? data[2] : [];
                  final randomRabbit = data.isNotEmpty ? data[1] : -1;

                  if (difference.inMinutes >= 3 &&
                      tappedHatNumbers.contains(randomRabbit)) {
                    final randomRabbit =
                        gameLogicRepository.generateRandomRabbitNumber();
                    saveTheRabbitRepository.saveTheRabbit([]);
                    saveStateAppRepository.saveStateApp([]);
                    saveTheRandomRabbitRepository
                        .saveTheRandomRabbit(randomRabbit);

                    final widgets = generateWidgetsRepository.generateWidgets(
                      context,
                      state,
                      [],
                      [],
                      randomRabbit,
                    );
                    return Stack(
                      children: widgets,
                    );
                  } else if (difference.inMinutes >= 3 &&
                      !tappedHatNumbers.contains(randomRabbit)) {
                    final widgets = generateWidgetsRepository.generateWidgets(
                      context,
                      state,
                      tappedHatNumbers,
                      rabbitNumber,
                      randomRabbit,
                    );
                    return Stack(
                      children: widgets,
                    );
                  } else {
                    return FutureBuilder<List<dynamic>>(
                      future: Future.wait([
                        loadTheRabbitRepository.loadTheRabbit(),
                        loadStateAppRepository.loadStateApp(),
                        loadTheRandomRabbitRepository.loadTheRandomRabbit(),
                      ]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final List<dynamic> data = snapshot.data ?? [];
                          final rabbitNumber = data.length > 1 ? data[0] : [];
                          final tappedHatNumbers =
                              data.length > 1 ? data[1] : [];
                          final randomRabbit = data.isNotEmpty ? data[2] : -1;

                          final widgets =
                              generateWidgetsRepository.generateWidgets(
                            context,
                            state,
                            tappedHatNumbers,
                            rabbitNumber,
                            randomRabbit,
                          );
                          return Stack(
                            children: [
                              ...widgets,
                              Center(
                                child: LuckWidgetRepositoryImpl()
                                    .buildLuckWidget(context, tappedHatNumbers),
                              ),
                            ],
                          );
                        }
                      },
                    );
                  }
                }
              },
            );
          } else {
            return FutureBuilder<List<dynamic>>(
              future: Future.wait([
                loadTheRabbitRepository.loadTheRabbit(),
                loadStateAppRepository.loadStateApp(),
                loadTheRandomRabbitRepository.loadTheRandomRabbit(),
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final List<dynamic> data = snapshot.data ?? [];
                  final rabbitNumber = data.length > 1 ? data[0] : [];
                  final tappedHatNumbers = data.length > 1 ? data[1] : [];
                  final randomRabbit = data.isNotEmpty ? data[2] : -1;

                  if (tappedHatNumbers.contains(randomRabbit)) {
                    saveGameEndTimeRepository.saveGameEndTime();
                    Future.delayed(const Duration(seconds: 2), () {
                      final luckWidget = LuckWidgetRepositoryImpl()
                          .buildLuckWidget(context, tappedHatNumbers);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Material(
                            type: MaterialType.transparency,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: luckWidget,
                              ),
                            ),
                          );
                        },
                      );
                    });
                  }

                  final widgets = generateWidgetsRepository.generateWidgets(
                    context,
                    state,
                    tappedHatNumbers,
                    rabbitNumber,
                    randomRabbit,
                  );

                  return Stack(
                    children: widgets,
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
