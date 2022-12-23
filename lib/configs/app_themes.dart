import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.teal,
  primaryColor: Colors.teal,
  scaffoldBackgroundColor: const Color.fromARGB(255, 240, 234, 234),
  fontFamily: 'ReemKufi',
  dividerColor: Colors.grey,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    foregroundColor: Colors.black,
    backgroundColor: Color.fromARGB(255, 240, 234, 234),
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20,
    backgroundColor: Colors.white,
    selectedIconTheme: IconThemeData(
      color: Colors.teal,
    ),
    unselectedIconTheme: IconThemeData(
      color: Colors.grey,
    ),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white,
    elevation: 20,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    titleTextStyle: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    contentTextStyle: TextStyle(
        fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
  ),
  snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 30,
      contentTextStyle: const TextStyle(color: Colors.black)),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color?>(
    Colors.teal,
  ))),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color?>(Colors.teal),
      shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color?>(Colors.teal),
    shape: MaterialStateProperty.all(const CircleBorder()),
  )),
  textTheme: const TextTheme(
    headline5: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
    headline4: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    headline6: TextStyle(
        fontWeight: FontWeight.bold, color: Color.fromARGB(226, 39, 38, 38)),
  ),
  cardTheme: CardTheme(
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    margin: const EdgeInsets.all(10),
  ),
  tabBarTheme: const TabBarTheme(
      labelColor: Colors.black,
      labelStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      )),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color.fromARGB(172, 52, 66, 73),
  scaffoldBackgroundColor: const Color(0xFF1A2127),
  fontFamily: 'ReemKufi',
  dividerColor: Colors.white,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Color(0xFF1A2127),
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 20,
    type: BottomNavigationBarType.fixed,
    backgroundColor: const Color(0x441C2A3D),
    selectedItemColor: const Color.fromRGBO(108, 99, 255, 1),
    selectedIconTheme: IconThemeData(
      color: Colors.grey[700],
    ),
    unselectedIconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white30,
    elevation: 20,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    titleTextStyle: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    contentTextStyle: TextStyle(
        fontSize: 15, fontWeight: FontWeight.normal, color: Colors.white),
  ),
  snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color.fromARGB(221, 0, 0, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 30,
      contentTextStyle: const TextStyle(color: Colors.black)),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color?>(
          const Color.fromRGBO(108, 99, 255, 1)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color?>(
          const Color.fromRGBO(108, 99, 255, 1)),
      shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color?>(
          const Color.fromRGBO(108, 99, 255, 1)),
      shape: MaterialStateProperty.all(const CircleBorder()),
    ),
  ),
  textTheme: const TextTheme(
    headline5: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
    headline4: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    headline6: TextStyle(
        fontWeight: FontWeight.bold, color: Color.fromARGB(255, 228, 222, 222)),
  ),
  cardTheme: CardTheme(
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    margin: const EdgeInsets.all(10),
    color: const Color.fromARGB(172, 52, 66, 73),
    shadowColor: const Color.fromARGB(172, 73, 92, 102),
  ),
  tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
      labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
);
