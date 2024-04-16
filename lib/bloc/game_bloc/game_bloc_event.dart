part of 'game_bloc_bloc.dart';

@immutable
sealed class GameBlocEvent {}

class RenderLuckWidgetEvent extends GameBlocEvent {}

final class HatTappedEvent extends GameBlocEvent {
  final int hatNumber;

  HatTappedEvent(this.hatNumber);
}

final class CheckAppState extends GameBlocEvent {}

final class RabbitAppearedEvent extends GameBlocEvent {
  final int hatNumber;
  final int winningNumber;
  RabbitAppearedEvent(this.winningNumber, this.hatNumber);
}
