import 'package:flutter/material.dart';

class MyThemeData{
  static ThemeData lightTheme()=> ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.green,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.black,
      )
    )
  );

  static Color creamColor =Color(0xfff5f5f5);
  static Color darkBluish =Color(0xff403b58);
  static Color mycolor =Colors.white10;


}