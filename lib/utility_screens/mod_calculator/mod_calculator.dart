import 'package:flutter/material.dart';
import 'package:upyogaarth/utility_screens/mod_calculator/ab_mod_n.dart';
import 'package:upyogaarth/utility_screens/mod_calculator/factorize.dart';
import 'package:upyogaarth/utility_screens/mod_calculator/gcd_ab.dart';
import 'package:upyogaarth/utility_screens/mod_calculator/x_mod_n.dart';

class ModCalculator extends StatefulWidget {
  const ModCalculator({Key? key}) : super(key: key);

  @override
  _ModCalculatorState createState() => _ModCalculatorState();
}

class _ModCalculatorState extends State<ModCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MOD Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const GcdAb()));
                  },
                  child: const Text('GCD(A , B)')),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const XModN()));
              },
              child: const Text('X\u207B\u00B9 MOD N')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AbModN()));
              },
              child: const Text('A\u1d2e MOD N')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (contet) => const Factorize()));
              },
              child: const Text('FACTORIZE')),
        ],
      ),
    );
  }
}
