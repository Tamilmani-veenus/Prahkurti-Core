import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../app_theme/app_theme.dart';
import '../../app_theme/theme_bloc/theme_state.dart';
import 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {

  ThemeBloc(ThemeState initialState) : super(initialState);

  ThemeState get initialState =>
      ThemeState(themeData: appThemeData[AppTheme.DeepPurpleAccent]);

  Stream<ThemeState> mapEventToState(
      ThemeEvent event,
      ) async* {
    if (event is ThemeChanged) {
      yield ThemeState(themeData: appThemeData[event.theme]);
    }
  }
}
