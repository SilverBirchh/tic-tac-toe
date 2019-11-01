import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/bloc/game/bloc.dart';
import 'package:tic_tac_toe/helpers/type.dart';

class ScoreBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (BuildContext context, GameState gameState) {
        final int xScore = gameState.game.xWins;
        final int oScore = gameState.game.totalGames - gameState.game.xWins;
        final isPVB = gameState.type.gameType == GAME_TYPE.PVB;
        final isBVB = gameState.type.gameType == GAME_TYPE.BVB;
        return Column(
          children: <Widget>[
            Text(
              'X wins: $xScore${isBVB ? ' (Bot)' : ''}',
              style: TextStyle(fontSize: 18),
            ),
            Divider(
              endIndent: 80,
              indent: 80,
            ),
            Text(
              'O wins: $oScore${isPVB || isBVB ? ' (Bot)' : ''}',
              style: TextStyle(fontSize: 18),
            )
          ],
        );
      },
    );
  }
}
