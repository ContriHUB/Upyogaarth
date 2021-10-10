import 'package:flutter/material.dart';

class XModN extends StatefulWidget {
  const XModN({Key? key}) : super(key: key);

  @override
  _XModNState createState() => _XModNState();
}

class _XModNState extends State<XModN> {
  final xCont = TextEditingController();
  final nCont = TextEditingController();
  double? ans;
  calc() {
    double a = double.parse(xCont.text);
    double b = double.parse(nCont.text);
    double sol = ((1 / a) % b).toDouble();
    setState(() {
      ans = sol;
    });
  }

  List<Widget> soln() {
    List<Widget> list = [];
    if (ans != null) {
      list.add(const Divider());
      list.add(Text(
        '${xCont.text} mod ${nCont.text} = $ans',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ));
    }
    return list;
  }

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
              decoration: InputDecoration(hintText: 'X: base'),
              keyboardType: TextInputType.number,
              controller: xCont,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'n: Modulus'),
              keyboardType: TextInputType.number,
              controller: nCont,
            ),
            ElevatedButton(
                onPressed: calc, child: const Text('CALCULATE INVERSE')),
            ElevatedButton(
                onPressed: () {
                  nCont.clear();
                  xCont.clear();
                  setState(() {
                    ans = null;
                  });
                },
                child: const Text('CLEAR')),
            ...soln(),
          ],
        ),
      ),
    );
  }
}
