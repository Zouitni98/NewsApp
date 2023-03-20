import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Screens/NewsScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  NewsScreen(),
    );
  }
}

