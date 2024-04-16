import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_your_luck_app/features/domain/game_logic_repository.dart';

part 'game_bloc_event.dart';
part 'game_bloc_state.dart';

class GameBloc extends Bloc<GameBlocEvent, GameBlocState> {
  final SaveStateAppRepository saveStateAppRepository;
  final LoadTheRandomRabbitRepository loadTheRandomRabbitRepository;
  final LoadStateAppRepository loadStateAppRepository;
  final LoadTheRabbitRepository loadTheRabbitRepository;
  final SaveTheRabbitRepository saveTheRabbitRepository;
  final GameLogicRepository gameLogicRepository;
  final SaveGameStartTimeRepository saveGameStartTimeRepository;
  final SaveGameEndTimeRepository saveGameEndTimeRepository;
  final LoadGameStartTimeRepository loadGameStartTimeRepository;
  final LoadGameEndTimeRepository loadGameEndTimeRepository;

  GameBloc(
    this.saveStateAppRepository,
    this.loadTheRandomRabbitRepository,
    this.loadStateAppRepository,
    this.loadTheRabbitRepository,
    this.saveTheRabbitRepository,
    this.gameLogicRepository,
    this.saveGameStartTimeRepository,
    this.saveGameEndTimeRepository,
    this.loadGameStartTimeRepository,
    this.loadGameEndTimeRepository,
  ) : super(GameBlocInitial()) {
    on<HatTappedEvent>((event, emitter) => _handleHatTaps(event, emitter));
  }

  Future<void> _handleHatTaps(
      HatTappedEvent event, Emitter<GameBlocState> emitter) async {
    final tappedHatNumbers = await loadStateAppRepository.loadStateApp();
    final rabbitNumber = await loadTheRabbitRepository.loadTheRabbit();
    final randomRabbit =
        await loadTheRandomRabbitRepository.loadTheRandomRabbit();
    final hatNumber = event.hatNumber;

    if (!tappedHatNumbers.contains(hatNumber)) {
      tappedHatNumbers.add(hatNumber);
      saveStateAppRepository.saveStateApp(tappedHatNumbers);
      {
        print('Number tapped $hatNumber');
        print('Numbers tapped $tappedHatNumbers');

        emitter(GameInProgress(hatNumber));
      }
    }
    if (!rabbitNumber.contains(hatNumber)) {
      rabbitNumber.add(hatNumber);
      saveTheRabbitRepository.saveTheRabbit(rabbitNumber);
      {
        print("rabbit number $rabbitNumber");
        emitter(GameInProgress(hatNumber));
      }
    }
    if (tappedHatNumbers.contains(randomRabbit)) {
      emitter(GameOver(randomRabbit));
    }
  }
}
