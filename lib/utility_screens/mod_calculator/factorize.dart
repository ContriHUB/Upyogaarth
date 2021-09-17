import 'package:flutter/material.dart';

class Factorize extends StatefulWidget {
  const Factorize({Key? key}) : super(key: key);

  @override
  _FactorizeState createState() => _FactorizeState();
}

class _FactorizeState extends State<Factorize> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FACTORIZE'),
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(hintText: 'My Number'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('FIND FACTORS')),
            ElevatedButton(onPressed: () {}, child: const Text('CLEAR')),
          ],
        ),
      ),
    );
  }
}
