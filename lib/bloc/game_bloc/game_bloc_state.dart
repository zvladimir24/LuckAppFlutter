part of 'game_bloc_bloc.dart';

@immutable
sealed class GameBlocState {}

final class GameBlocInitial extends GameBlocState {}

final class GameInProgress extends GameBlocState {
  final int tappedHatNumber;

  GameInProgress(this.tappedHatNumber);
}

final class GameOver extends GameBlocState {
  final int winningNumber;

  GameOver(this.winningNumber);
}
