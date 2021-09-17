import 'package:flutter/material.dart';

class XModN extends StatefulWidget {
  const XModN({Key? key}) : super(key: key);

  @override
  _XModNState createState() => _XModNState();
}

class _XModNState extends State<XModN> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('X\u207B\u00B9 MOD N'),
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  hintText: 'X: base'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'n: Modulus'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(onPressed: () {

            }, child: const Text('CALCULATE INVERSE')),
            ElevatedButton(onPressed: () {

            }, child: const Text('CLEAR')),
          ],
        ),
      ),
    );
  }
}
