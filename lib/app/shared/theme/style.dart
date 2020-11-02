import 'package:flutter/material.dart';

import 'colors.dart';

final appTheme = ThemeData(
  primaryColor: ColorsSet.primaryColor,
  accentColor: ColorsSet.accentColor,
  iconTheme: IconThemeData(
    color: ColorsSet.primaryColor
  ),
  textTheme: TextTheme(
    button: TextStyle(fontSize: 18.0),
    headline1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    headline3: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    headline4: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    headline5: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
    bodyText1: TextStyle(fontSize: 18.0, letterSpacing: 1.0, wordSpacing: 2.0, height: 1.5, color: Colors.black87),
    bodyText2: TextStyle(fontSize: 16.0, letterSpacing: 1.0, wordSpacing: 2.0, height: 1.5, color: Colors.grey[500]),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: ColorsSet.primaryColor,
    unselectedItemColor: Colors.grey[600]
  )
);