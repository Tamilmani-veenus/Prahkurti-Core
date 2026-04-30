import 'package:flutter/material.dart';
import 'app_colors.dart';

enum AppTheme {
  OrangeLight,
  GreenLight,
  GreenDark,
  BlueLight,
  BlueDark,
  WhiteLight,
  RedLight,
  RedDark,
  IndigoLight,
  DeepPurpleAccent,
}

final appThemeData = {
  AppTheme.OrangeLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.orange,
    primaryColorLight: Colors.orange[200],
    inputDecorationTheme: new InputDecorationTheme(
      labelStyle: new TextStyle(color: Colors.orange),

    ),
  ),

  AppTheme.GreenLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.green,
    primaryColorLight: Colors.green[200],
    fontFamily: fontFamily,
  ),

  AppTheme.RedLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.red,
    primaryColorLight: Colors.red[200],
    fontFamily: fontFamily,
    // hintColor: Colors.red,
    //accentColor: Colors.red,
    // cursorColor:Colors.red,
  ),

  AppTheme.RedDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.red[700],
    fontFamily: fontFamily,
    primaryColorLight: Colors.red[200],
   // accentColor: Colors.red,
    // cursorColor:Colors.red,
  ),

  AppTheme.GreenDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green[700],
    fontFamily: fontFamily,
  ),

  AppTheme.BlueLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue[700],
    fontFamily: fontFamily,
    primaryColorLight: Colors.blue[200],
    // cursorColor:Colors.blue,
    // iconTheme: IconThemeData(
    //     color: iconfColor
    // ),
    // primaryIconTheme: IconThemeData(
    //     color: iconsColor
    // ),
  ),

  AppTheme.BlueDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue[700],
    fontFamily: fontFamily,
  ),

  AppTheme.WhiteLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    fontFamily: fontFamily,
  ),


  AppTheme.IndigoLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.indigo,
    fontFamily: fontFamily,
    primaryColorLight: Colors.indigo[200],
    // cursorColor:Colors.blue,
  ),


  AppTheme.DeepPurpleAccent: ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF4B3FFF),
    fontFamily: fontFamily,
    primaryColorLight: Colors.deepPurpleAccent[200],
    useMaterial3: false,
    // cursorColor:Colors.blue,
  ),


};
