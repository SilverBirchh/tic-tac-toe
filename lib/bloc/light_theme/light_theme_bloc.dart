import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class LightThemeBloc extends Bloc<LightThemeEvent, bool> {
  LightThemeBloc(this.useLightTheme);

  final bool useLightTheme;
  
  @override
  bool get initialState => useLightTheme;

  @override
  Stream<bool> mapEventToState(
    LightThemeEvent event,
  ) async* {
    switch (event) {
      case LightThemeEvent.on:
        yield true;
        break;
      case LightThemeEvent.off:
        yield false;
        break;
    }
  }
}
