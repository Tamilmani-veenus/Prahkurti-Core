import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../app_theme.dart';


@immutable
abstract class ThemeEvent extends Equatable {
  ThemeEvent([List props = const <dynamic>[]]) : super();
}

class ThemeChanged extends ThemeEvent {
  final AppTheme theme;

  ThemeChanged({
    required this.theme,
  }) : super();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
