import 'package:flutter/material.dart';
import 'package:fullscreen_vedio_app/screens/learning_module/learning_module.dart';

import 'screens/my_home_page.dart';
// Import for Timer

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Video Background Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LearningModule(),
    );
  }
}
