import 'package:flutter/material.dart';

class GcdAb extends StatefulWidget {
  const GcdAb({Key? key}) : super(key: key);

  @override
  _GcdAbState createState() => _GcdAbState();
}

class _GcdAbState extends State<GcdAb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GCD(a,b)'),
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                  hintText: 'a'),
              keyboardType: TextInputType.number,
            ),
            const TextField(
              decoration: InputDecoration(
                  hintText: 'b'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(onPressed: () {

            }, child: const Text('CALCULATE GCD')),
            ElevatedButton(onPressed: () {

            }, child: const Text('BEZOUT IDENTITY')),
            ElevatedButton(onPressed: () {

            }, child: const Text('CLEAR')),
          ],
        ),
      ),
    );
  }
}
