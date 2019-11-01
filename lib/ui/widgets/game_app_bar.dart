import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/bloc/game/bloc.dart';
import 'package:tic_tac_toe/bloc/light_theme/bloc.dart';

class GameAppBar extends StatelessWidget implements PreferredSizeWidget {
  GameAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);
  @override
  final Size preferredSize;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightThemeBloc, bool>(
      builder: (BuildContext context, bool useLightTheme) {
        return AppBar(
          title: Text('Tic Tac Toe'),
          actions: <Widget>[
            IconButton(
              color: Colors.white,
              onPressed: () {
                BlocProvider.of<GameBloc>(context).add(ResetGame());
              },
              icon: Icon(Icons.refresh),
            ),
            IconButton(
              color: Colors.white,
              onPressed: () async {
                BlocProvider.of<LightThemeBloc>(context).add(
                    useLightTheme ? LightThemeEvent.off : LightThemeEvent.on);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('useLightTheme', !useLightTheme);
              },
              icon: useLightTheme
                  ? Icon(Icons.brightness_3)
                  : Icon(Icons.wb_sunny),
            )
          ],
        );
      },
    );
  }
}
