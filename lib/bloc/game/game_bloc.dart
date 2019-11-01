import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:tic_tac_toe/api/winner.dart';
import 'package:tic_tac_toe/data/game.dart';
import 'package:tic_tac_toe/helpers/type.dart';
import './bloc.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc(this.type);

  final Type type;
  final Winner winner = Winner();

  @override
  GameState get initialState => InitialGameState(
      Game(
        totalGames: 0,
        xHasWon: false,
        xIsNext: true,
        xWins: 0,
        squares: List(9),
      ),
      type);

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is TakeGo) {
      yield* _takeGoToState(event, state);
    } else if (event is ResetGame) {
      yield* _resetGameToState(event, state);
    } else if (event is ShowWinner) {
      yield* _showWinnerToState(event, state);
    } else if (event is TakeBotGo) {
      yield* _takeBotGoToState(event, state);
    } else if (event is ShowDraw) {
      yield* _showDrawToState(event, state);
    } else if (event is StartGame) {
      yield* _startGameToState(event, state);
    }
  }

  Stream<GameState> _startGameToState(StartGame event, GameState state) async* {
    if (type.gameType == GAME_TYPE.BVB) {
      add(TakeBotGo());
    }
  }

  Stream<GameState> _takeGoToState(TakeGo event, GameState state) async* {
    final Game newGameState = state.game
        .copyWith(squares: state.game.squares, xIsNext: !state.game.xIsNext);
    newGameState.squares[event.index] = state.game.xIsNext ? 'X' : 'O';
    final String result = winner.calculateWinner(newGameState.squares);
    if (result == 'WIN') {
      add(
        ShowWinner(state.game.xIsNext),
      );
    } else if (result == 'DRAW') {
      add(
        ShowDraw(),
      );
    } else {
      yield MidGame(newGameState, type);
      if (_shouldInitiateBotTurn(newGameState)) {
        add(TakeBotGo());
      }
    }
  }

  Stream<GameState> _resetGameToState(ResetGame event, GameState state) async* {
    final Game newGameState = state.game.copyWith(
      xIsNext: !state.game.xIsNext,
      squares: List(9),
    );
    yield InitialGameState(newGameState, type);

    if (_shouldInitiateBotTurn(newGameState)) {
      add(TakeBotGo());
    }
  }

  Stream<GameState> _showWinnerToState(
      ShowWinner event, GameState state) async* {
    final finalGameState = state.game.copyWith(
        xHasWon: event.xHasWon,
        totalGames: ++state.game.totalGames,
        xWins: event.xHasWon ? ++state.game.xWins : state.game.xWins);
    yield GameOver(finalGameState, type);
  }

  Stream<GameState> _showDrawToState(ShowDraw event, GameState state) async* {
    yield Draw(state.game, type);
  }

  Stream<GameState> _takeBotGoToState(TakeBotGo event, GameState state) async* {
    final int index = _randomIndex(state);

    if (type.gameType == GAME_TYPE.BVB) {
      await Future.delayed(
        Duration(seconds: 1),
      );
    }

    add(TakeGo(index: index));
  }

  int _randomIndex(GameState state) {
    final Random randomizer = Random();
    final int index = randomizer.nextInt(9);

    if (state.game.squares[index] != null) {
      return _randomIndex(state);
    } else {
      return index;
    }
  }

  bool _shouldInitiateBotTurn(Game game) {
    return (type.gameType == GAME_TYPE.PVB && !game.xIsNext) ||
        state.type.gameType == GAME_TYPE.BVB;
  }
}
