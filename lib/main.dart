import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './pages/home_page.dart';

void main() async {
  await Hive.initFlutter();

  //open a box
  var box = await Hive.openBox('MyBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo',
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}
