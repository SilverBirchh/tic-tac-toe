import 'package:flutter/material.dart';
import 'package:tic_tac_toe/ui/widgets/bold_text.dart';
import 'package:tic_tac_toe/helpers/type.dart';

class Landing extends StatelessWidget {
  final GlobalKey<ScaffoldState> _calculatorKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _calculatorKey,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  BoldText(
                    text: 'TIC',
                    color: Colors.red,
                  ),
                  BoldText(
                    text: 'TAC',
                    color: Colors.green,
                  ),
                  BoldText(
                    text: 'TOE',
                    color: Colors.blue,
                  ),
                ],
              ),
              SizedBox(
                width: 250,
                height: 175,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/play',
                            arguments: Type(GAME_TYPE.PVP));
                      },
                      child: Text(
                        'Player vs Player',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/play',
                            arguments: Type(GAME_TYPE.PVB));
                      },
                      child: Text(
                        'Player vs Bot',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/play',
                            arguments: Type(GAME_TYPE.BVB));
                      },
                      child: Text(
                        'Bot vs Bot',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
