import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/bloc/game/bloc.dart';
import 'package:tic_tac_toe/helpers/type.dart';
import 'package:tic_tac_toe/ui/widgets/next_player.dart';
import 'package:tic_tac_toe/ui/widgets/score_board.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {

  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (BuildContext context, GameState gameState) {
        return ListView(
          controller: _controller,
          physics: (gameState is GameOver || gameState is Draw) ? NeverScrollableScrollPhysics() : null,
          children: <Widget>[
            Stack(
              overflow: Overflow.visible,
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                NextPlayer(),
                Column(
                  children: <Widget>[
                    Container(
                      child: GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
                        itemCount: 9,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0),
                        itemBuilder: (BuildContext context, int index) {
                          final String value = gameState.game.squares[index];
                          return GestureDetector(
                            onTap: () {
                              if (gameState.game.squares[index] != null) {
                                return;
                              }
                              if ((gameState.type.gameType == GAME_TYPE.PVB &&
                                      gameState.game.xIsNext) ||
                                  gameState.type.gameType != GAME_TYPE.BVB)
                                BlocProvider.of<GameBloc>(context).add(
                                  TakeGo(index: index),
                                );
                              return;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.teal),
                              ),
                              child: value != null
                                  ? Center(
                                      child: Text(
                                        value,
                                        style: TextStyle(fontSize: 40),
                                      ),
                                    )
                                  : Container(
                                      width: 0,
                                      height: 0,
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ScoreBoard(),
                    ),
                  ],
                ),
                if (gameState is GameOver || gameState is Draw)
                  Opacity(
                    opacity: .8,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                    ),
                  ),
                if (gameState is GameOver || gameState is Draw)
                  _showWinnersDialog(gameState, context),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _showWinnersDialog(GameState gameState, BuildContext context) {
    final String winner = gameState.game.xHasWon ? 'X' : 'O';
    _controller.jumpTo(0);
    return Positioned.fill(
      top: 200,
      child: SizedBox(
        height: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (gameState is GameOver)
              Text(
                '$winner has won the game! Congratulations!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            if (gameState is Draw)
              Text(
                'It was a draw!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () =>
                      BlocProvider.of<GameBloc>(context).add(ResetGame()),
                  child: Text('Play again'),
                ),
                RaisedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, '/', (Route<dynamic> route) => false),
                  child: Text('Quit'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
