import 'package:meta/meta.dart';

@immutable
abstract class GameEvent {}

class TakeGo extends GameEvent {
  TakeGo({this.index});

  final int index;
}

class StartGame extends GameEvent {}

class TakeBotGo extends GameEvent {}

class ShowDraw extends GameEvent {}

class ShowWinner extends GameEvent {
  ShowWinner(this.xHasWon);

  final bool xHasWon;
}

class ResetGame extends GameEvent {}
