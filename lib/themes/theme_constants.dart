import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
  ),
  colorScheme: ColorScheme.light(
    primary: const Color.fromARGB(255, 255, 255, 255),
    secondary: const Color.fromARGB(255, 14, 60, 139),
  ),
   textTheme: TextTheme(
    titleSmall: TextStyle(color: const Color.fromARGB(255, 0, 0, 0),fontSize: 12,fontWeight: FontWeight.bold),
    titleLarge: TextStyle(color: const Color.fromARGB(255, 8, 84, 217),fontSize: 50,fontWeight: FontWeight.w500),
   titleMedium: TextStyle(color: const Color.fromARGB(255, 0, 0, 0),fontSize: 16,fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 24,fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(color: const Color.fromARGB(255, 8, 84, 217), fontSize: 26,fontWeight: FontWeight.bold),

  ),
  );

  ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 0, 0, 0),
  ),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
    primary: Color.fromARGB(165, 255, 255, 255),
    secondary: const Color.fromARGB(255, 40, 51, 70),
  ),
    textTheme: TextTheme(
         titleSmall: TextStyle(color: const Color.fromARGB(255, 255, 255, 255),fontSize: 12,fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: const Color.fromARGB(255, 8, 84, 217),fontSize: 50,fontWeight: FontWeight.w500),
      titleMedium: TextStyle(color: const Color.fromARGB(255, 0, 0, 0),fontSize: 16,fontWeight: FontWeight.bold),
     bodyMedium: TextStyle(color: const Color.fromARGB(255, 252, 252, 252), fontSize: 24,fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(color: const Color.fromARGB(255, 8, 84, 217), fontSize: 26,fontWeight: FontWeight.bold),
  ),
  );