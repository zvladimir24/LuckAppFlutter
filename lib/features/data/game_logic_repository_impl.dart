import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:test_your_luck_app/bloc/game_bloc/game_bloc_bloc.dart';
import 'package:test_your_luck_app/features/domain/game_logic_repository.dart';
import 'package:test_your_luck_app/features/presentation/widgets/flower_widget.dart';

import 'package:test_your_luck_app/features/presentation/widgets/hat_widget.dart';
import 'package:test_your_luck_app/features/presentation/widgets/luck_widget.dart';
import 'package:test_your_luck_app/features/presentation/widgets/rabbit_widget.dart';

class GameLogicRepositoryImpl implements GameLogicRepository {
  @override
  int generateRandomRabbitNumber() {
    Random random = Random();
    return random.nextInt(7) + 1;
  }
}

class GenerateWidgetsRepositoryImpl implements GenerateWidgetsRepository {
  final SharedPreferences prefs;
  final SaveStateAppRepository saveStateAppRepository;

  final SaveTheRabbitRepository saveTheRabbitRepository;

  final SaveTheRandomRabbitRepository saveTheRandomRabbitRepository;

  final List<int> rabbitNumber;

  final List<int> tappedHatNumbers;

  final int randomRabbit;

  GenerateWidgetsRepositoryImpl(
    this.prefs,
    this.tappedHatNumbers,
    this.saveStateAppRepository,
    this.rabbitNumber,
    this.saveTheRabbitRepository,
    this.saveTheRandomRabbitRepository,
    this.randomRabbit,
  );

  @override
  List<Widget> generateWidgets(
    BuildContext context,
    GameBlocState state,
    List<int> tappedHatNumbers,
    List<int> rabbitNumber,
    int randomRabbit,
  ) {
    bool isEmpty = tappedHatNumbers.isEmpty && rabbitNumber.isEmpty;

    List<Widget> widgets = [];
    for (int hatNumber = 1; hatNumber <= 7; hatNumber++) {
      if (isEmpty) {
        widgets.add(
          Positioned(
            top: hatWidgetPositionTop(hatNumber),
            left: hatWidgetPositionLeft(hatNumber),
            child: GestureDetector(
              onTap: () {
                if (!tappedHatNumbers.contains(randomRabbit)) {
                  context.read<GameBloc>().add(HatTappedEvent(hatNumber));
                }
              },
              child: const Hat(),
            ),
          ),
        );
      } else {
        widgets.add(
          Positioned(
            top: hatWidgetPositionTop(hatNumber),
            left: hatWidgetPositionLeft(hatNumber),
            child: GestureDetector(
              onTap: () {
                if (!tappedHatNumbers.contains(randomRabbit)) {
                  context.read<GameBloc>().add(HatTappedEvent(hatNumber));
                }
              },
              child: Column(
                children: [
                  const Hat(),
                  if (rabbitNumber.contains(randomRabbit) &&
                      hatNumber == randomRabbit) ...[
                    const Rabbit(),
                  ] else if (tappedHatNumbers.contains(hatNumber)) ...[
                    const Flower(),
                  ]
                ],
              ),
            ),
          ),
        );
      }
    }
    return widgets;
  }

  double hatWidgetPositionTop(int hatNumber) {
    int rowIndex = ((hatNumber + 4) / 3).floor();
    return rowIndex * 170.0;
  }

  double hatWidgetPositionLeft(int hatNumber) {
    int colIndex = (hatNumber + 6) % 3;
    return colIndex * 140.0;
  }
}

class LuckWidgetRepositoryImpl implements LuckWidgetRepository {
  @override
  Widget buildLuckWidget(BuildContext context, List<int> tappedHatNumbers) {
    final luckPercentage = calculateLuckPercentage(tappedHatNumbers.length);
    return LuckWidget(luckPercentage: luckPercentage);
  }

  @override
  double calculateLuckPercentage(int tappedHatCount) {
    if (tappedHatCount == 0) {
      return 0;
    } else if (tappedHatCount == 1) {
      return 100;
    } else if (tappedHatCount == 2) {
      return 86;
    } else if (tappedHatCount == 3) {
      return 71;
    } else if (tappedHatCount == 4) {
      return 57;
    } else if (tappedHatCount == 5) {
      return 43;
    } else if (tappedHatCount == 6) {
      return 29;
    } else if (tappedHatCount == 7) {
      return 14;
    } else {
      return 0;
    }
  }
}

class SaveGameStartTimeRepositoryImpl implements SaveGameStartTimeRepository {
  @override
  Future<void> saveGameStartTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final DateTime now = DateTime.now();
    final int timestamp = now.millisecondsSinceEpoch;
    await prefs.setInt('gameStartTime', timestamp);
    print('Game Start Time saved: $timestamp');
  }
}

class SaveGameEndTimeRepositoryImpl implements SaveGameEndTimeRepository {
  @override
  Future<void> saveGameEndTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final DateTime now = DateTime.now();
    final int timestamp = now.millisecondsSinceEpoch;
    await prefs.setInt('gameEndTime', timestamp);
    print('Game End Time saved: $timestamp');
  }
}

class LoadGameStartTimeRepositoryImpl implements LoadGameStartTimeRepository {
  final SaveGameStartTimeRepository saveGameStartTimeRepository;

  LoadGameStartTimeRepositoryImpl(this.saveGameStartTimeRepository);
  @override
  Future<int?> loadGameStartTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? timestamp = prefs.getInt('gameStartTime');
    if (timestamp != null) {
      print('Game Start Time loaded: $timestamp');
      return timestamp;
    } else {
      print('No game start time found. Setting initial value.');
      await saveGameStartTimeRepository.saveGameStartTime();
      return null;
    }
  }
}

class LoadGameEndTimeRepositoryImpl implements LoadGameEndTimeRepository {
  final SaveGameEndTimeRepository saveGameEndTimeRepository;

  LoadGameEndTimeRepositoryImpl(this.saveGameEndTimeRepository);
  @override
  Future<int?> loadGameEndTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? timestamp = prefs.getInt('gameEndTime');
    if (timestamp != null) {
      print('Game End Time loaded: $timestamp');
      return timestamp;
    } else {
      print('No game end time found. Setting initial value.');
      await saveGameEndTimeRepository.saveGameEndTime();
      return null;
    }
  }
}

class SaveStateAppRepositoryImpl implements SaveStateAppRepository {
  final SharedPreferences prefs;
  SaveStateAppRepositoryImpl(this.prefs);
  @override
  Future<void> saveStateApp(List<int> tappedHatNumbers) async {
    await prefs.setStringList(
        'tappedHatNumbers', tappedHatNumbers.map((e) => e.toString()).toList());
  }
}

class LoadStateAppRepositoryImpl implements LoadStateAppRepository {
  final SharedPreferences prefs;
  LoadStateAppRepositoryImpl(this.prefs);

  @override
  Future<List<int>> loadStateApp() async {
    final list = prefs.getStringList('tappedHatNumbers');
    return list?.map((e) => int.parse(e)).toList() ?? [];
  }
}

class SaveTheRabbitRepositoryImpl implements SaveTheRabbitRepository {
  final SharedPreferences prefs;

  SaveTheRabbitRepositoryImpl(this.prefs);
  @override
  Future<void> saveTheRabbit(List<int> rabbitNumber) async {
    await prefs.setStringList(
        'rabbitNumber', rabbitNumber.map((e) => e.toString()).toList());
  }
}

class LoadTheRabbitRepositoryImpl implements LoadTheRabbitRepository {
  final SharedPreferences prefs;

  LoadTheRabbitRepositoryImpl(this.prefs);

  @override
  Future<List<int>> loadTheRabbit() async {
    final list = prefs.getStringList('rabbitNumber');
    return list?.map((e) => int.parse(e)).toList() ?? [];
  }
}

class SaveTheRandomRabbitRepositoryImpl
    implements SaveTheRandomRabbitRepository {
  final SharedPreferences prefs;

  SaveTheRandomRabbitRepositoryImpl(this.prefs);
  @override
  Future<void> saveTheRandomRabbit(int randomRabbit) async {
    await prefs.setInt('randomRabbit', randomRabbit);
  }
}

class LoadTheRandomRabbitRepositoryImpl
    implements LoadTheRandomRabbitRepository {
  final SharedPreferences prefs;

  LoadTheRandomRabbitRepositoryImpl(this.prefs);

  @override
  Future<int> loadTheRandomRabbit() async {
    final randomRabbit = prefs.getInt('randomRabbit');
    return randomRabbit ?? -1;
  }
}

class YourLuckRepositoryImpl implements YourLuckRepository {
  static const _luckPercentageKey = 'luck_percentage';

  @override
  Future<void> saveLuckPercentage(double percentage) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_luckPercentageKey, percentage);
  }

  @override
  Future<double?> loadLuckPercentage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_luckPercentageKey);
  }
}
