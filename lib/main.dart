import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/ui/screens/landing.dart';
import 'package:tic_tac_toe/ui/screens/play.dart';
import 'package:tic_tac_toe/ui/widgets/slide.dart';

import 'bloc/light_theme/light_theme_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    BlocProvider<LightThemeBloc>(
      builder: (BuildContext context) =>
          LightThemeBloc((prefs.getBool('useLightTheme') ?? true)),
      child: TicTacToe(),
    ),
  );
}

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightThemeBloc, bool>(
      builder: (BuildContext context, bool useLightTheme) {
        return MaterialApp(
          title: 'Tic Tac Tow',
          theme: useLightTheme ? ThemeData.light() : ThemeData.dark(),
          initialRoute: '/',
          home: Landing(),
          onGenerateRoute: (settings) {
            if (settings.name == "/play") {
              return SlideLeftRoute(page: Play(settings.arguments));
            } else if (settings.name == '/') {
              return SlideUpRoute(page: Landing());
            }
            // unknown route
            return MaterialPageRoute(builder: (context) => Container());
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
