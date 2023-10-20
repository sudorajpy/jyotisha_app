import 'package:flutter/material.dart';
import 'package:jyotisha_app/panchang_screen.dart';
import 'package:jyotisha_app/splash_screen.dart';
import 'package:jyotisha_app/tab_screen.dart';
import 'package:jyotisha_app/test.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen()
    );
  }
}

