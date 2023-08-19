import 'package:flutter/material.dart';
import 'package:flutter_qualif/pages/home_page.dart';
import 'package:flutter_qualif/pages/login_page.dart';
import 'package:flutter_qualif/pages/main_page.dart';
import 'package:flutter_qualif/theme/dark_theme.dart';
import 'package:flutter_qualif/theme/light_theme.dart';
import 'package:flutter_qualif/theme/theme_class.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Threads",
      theme: ThemeClass.isDarkMode ? darkTheme : lightTheme,
      darkTheme: ThemeClass.isDarkMode ? darkTheme : lightTheme,
      home: const LoginPage(),
    );  
  }
}

MaterialColor _createBlackSwatch() {
  const int blackPrimaryValue = 0xFF000000;
  return const MaterialColor(blackPrimaryValue, {
    50: Color(0xFFE0E0E0),
    100: Color(0xFFB0B0B0),
    200: Color(0xFF808080),
    300: Color(0xFF505050),
    400: Color(0xFF303030),
    500: Color(blackPrimaryValue),
    600: Color(0xFF101010),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  });
}