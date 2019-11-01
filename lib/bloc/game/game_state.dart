import 'package:meta/meta.dart';
import 'package:tic_tac_toe/data/game.dart';
import 'package:tic_tac_toe/helpers/type.dart';

@immutable
abstract class GameState {
  GameState(this.game, this.type);

  final Type type;
  final Game game;
}

class InitialGameState extends GameState {
  InitialGameState(Game game, Type type) : super(game, type);
}

class GameOver extends GameState {
  GameOver(Game game, Type type) : super(game, type);
}

class Draw extends GameState {
  Draw(Game game, Type type) : super(game, type);
}

class MidGame extends GameState {
  MidGame(Game game, Type type) : super(game, type);
}
