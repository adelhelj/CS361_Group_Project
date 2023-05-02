import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:grateful/pages/home_page.dart';
import 'package:grateful/pages/start_page.dart';

void main() async {
  await Hive.initFlutter("hive_boxes");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grateful Micro Alpha v0.1.0',
      theme: _myThemeData(),
      initialRoute: 'start',
      routes: {
        'start':(context) => const StartPage(),
        'home': (context) => const HomePage(),
      }
      // home: const HomePage(),
    );
  }

  ThemeData _myThemeData() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'ProximaNova',
      colorScheme: ColorScheme
        .fromSeed(seedColor: const Color.fromRGBO(217, 192, 233, 1.0)),
      canvasColor: const Color.fromRGBO(217, 192, 233, 1.0),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(217, 192, 233, 1.0)
      ),
    );
  }
}
