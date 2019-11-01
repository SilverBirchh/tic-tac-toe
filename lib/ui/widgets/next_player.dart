import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/bloc/game/bloc.dart';

class NextPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (BuildContext context, GameState gameState) {
        final String nextPlayer = gameState.game.xIsNext ? 'X' : 'O';
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Text('$nextPlayer is next to go...', style: TextStyle(fontSize: 18)),
        );
      },
    );
  }
}
