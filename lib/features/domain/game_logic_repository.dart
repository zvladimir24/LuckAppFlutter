import 'package:flutter/material.dart';
import 'package:test_your_luck_app/bloc/game_bloc/game_bloc_bloc.dart';

abstract interface class GameLogicRepository {
  int generateRandomRabbitNumber();
}

abstract interface class GenerateWidgetsRepository {
  List<Widget> generateWidgets(BuildContext context, GameBlocState state,
      List<int> tappedHatNumbers, List<int> rabbitNumber, int randomRabbit);
}

abstract interface class LuckWidgetRepository {
  Widget buildLuckWidget(BuildContext context, List<int> tappedHatNumbers);
  double calculateLuckPercentage(int tappedHatCount);
}

abstract interface class SaveGameStartTimeRepository {
  Future<void> saveGameStartTime();
}

abstract interface class SaveGameEndTimeRepository {
  Future<void> saveGameEndTime();
}

abstract interface class LoadGameStartTimeRepository {
  Future<int?> loadGameStartTime();
}

abstract interface class LoadGameEndTimeRepository {
  Future<int?> loadGameEndTime();
}

abstract interface class SaveStateAppRepository {
  Future<void> saveStateApp(List<int> tappedHatNumbers);
}

abstract interface class LoadStateAppRepository {
  Future<List<int>> loadStateApp();
}

abstract interface class SaveTheRabbitRepository {
  Future<void> saveTheRabbit(List<int> rabbitNumber);
}

abstract interface class SaveTheRandomRabbitRepository {
  Future<void> saveTheRandomRabbit(int randomRabbit);
}

abstract interface class LoadTheRandomRabbitRepository {
  Future<int> loadTheRandomRabbit();
}

abstract interface class LoadTheRabbitRepository {
  Future<List<int>> loadTheRabbit();
}

abstract interface class YourLuckRepository {
  Future<void> saveLuckPercentage(double percentage);
  Future<double?> loadLuckPercentage();
}
