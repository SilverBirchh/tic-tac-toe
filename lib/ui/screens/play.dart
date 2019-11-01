import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/bloc/game/bloc.dart';
import 'package:tic_tac_toe/helpers/type.dart';
import 'package:tic_tac_toe/ui/widgets/board.dart';
import 'package:tic_tac_toe/ui/widgets/game_app_bar.dart';

class Play extends StatelessWidget {
  Play(this.type);
  final Type type;
  final GlobalKey<ScaffoldState> _playKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameBloc>(
        builder: (BuildContext context) => GameBloc(type)..add(StartGame()),
        child: Scaffold(
          key: _playKey,
          appBar: GameAppBar(),
          body: ListView(
            children: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height - 87,
                  width: MediaQuery.of(context).size.width,
                  child: Board(),
                ),
              ),
            ],
          ),
        ));
  }
}
