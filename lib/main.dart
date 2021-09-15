import 'package:flutter/material.dart';
import 'package:upyogaarth/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upyogaarth',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      darkTheme: ThemeData.dark(),
      home: const HomePage(title: 'Upyogaarth'),
      debugShowCheckedModeBanner: false,
    );
  }
}
