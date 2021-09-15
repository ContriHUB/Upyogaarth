import 'package:flutter/material.dart';
import 'package:upyogaarth/widgets/homecard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              HomeCard(title: "Flashlight"),
              HomeCard(title: "Compass")
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              HomeCard(title: "Weather"),
              HomeCard(title: "MOD Calculator")
            ])
          ],
        ));
  }
}
