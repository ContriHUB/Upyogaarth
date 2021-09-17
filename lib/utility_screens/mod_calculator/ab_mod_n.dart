import 'package:flutter/material.dart';

class AbModN extends StatefulWidget {
  const AbModN({Key? key}) : super(key: key);

  @override
  _AbModNState createState() => _AbModNState();
}

class _AbModNState extends State<AbModN> {
  bool _showSteps = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A\u1d2e MOD N'),
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(hintText: 'a: Base'),
              keyboardType: TextInputType.number,
            ),
            const TextField(
              decoration: InputDecoration(hintText: 'b: Power'),
              keyboardType: TextInputType.number,
            ),
            const TextField(
              decoration: InputDecoration(hintText: 'n: Mod'),
              keyboardType: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text("Show Steps"),
                Switch(
                    value: _showSteps,
                    activeTrackColor: Colors.yellow,
                    activeColor: Colors.orangeAccent,
                    onChanged: (value) {
                      setState(() => {_showSteps = value});
                    }),
              ],
            ),
            ElevatedButton(
                onPressed: () {}, child: const Text('COMPUTE POWER')),
            ElevatedButton(onPressed: () {}, child: const Text('CLEAR')),
          ],
        ),
      ),
    );
  }
}
