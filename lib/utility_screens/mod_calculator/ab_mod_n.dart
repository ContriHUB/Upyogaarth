import 'package:flutter/material.dart';
import 'dart:math';

class AbModN extends StatefulWidget {
  const AbModN({Key? key}) : super(key: key);

  @override
  _AbModNState createState() => _AbModNState();
}

class _AbModNState extends State<AbModN> {
  bool _showSteps = false;
  final aCont = TextEditingController();
  final bCont = TextEditingController();
  final nCont = TextEditingController();
  num? ans;
  String s1 = "";
  String s2 = "";

  calc() {
    num a = num.parse(aCont.text);
    num b = num.parse(bCont.text);
    num n = num.parse(nCont.text);
    num sol = pow(a, b) % n;
    String str1 = "$a ^ $b" " % " + n.toString() + " => ";
    String str2 =
        pow(a, b).toString() + " % " + n.toString() + " = " + sol.toString();
    print(sol);
    setState(() {
      ans = sol;
      s1 = str1;
      s2 = str2;
    });
  }

  List<Widget> soln() {
    List<Widget> list = [];
    if (ans != null) {
      list.add(const Divider());
      if (_showSteps && s1!="" && s2!="") {
        list.add(Text(
          s1,
          style: const TextStyle(fontSize: 20),
        ));
        list.add(Text(
          s2,
          style: const TextStyle(fontSize: 20),
        ));
      }
      list.add(Text(
        "Answer = $ans",
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('A\u1d2e MOD N'),
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30.0,width:double.infinity),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                decoration: const InputDecoration(hintText: 'a: Base',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey,
                  width: 2.5,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(23, 195, 178, 100),
                  width: 2.5,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                ),
                keyboardType: TextInputType.number,
                controller: aCont,
              ),
            ),
            const SizedBox(height: 16.0,width:double.infinity),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                decoration: const InputDecoration(hintText: 'b: Power',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey,
                  width: 2.5,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(23, 195, 178, 100),
                  width: 2.5,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                ),
                keyboardType: TextInputType.number,
                controller: bCont,
              ),
            ),
            const SizedBox(height: 16.0,width:double.infinity),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                decoration: const InputDecoration(hintText: 'n: Mod',
                   enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey,
                  width: 2.5,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(23, 195, 178, 100),
                  width: 2.5,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                ),
                keyboardType: TextInputType.number,
                controller: nCont,
              ),
            ),
            const SizedBox(height: 10.0,width:double.infinity),
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
            ElevatedButton(onPressed: calc, child: const Text('COMPUTE POWER')),
            ElevatedButton(
                onPressed: () {
                  aCont.clear();
                  bCont.clear();
                  nCont.clear();
                  setState(() {
                    ans = null;
                    s1 = "";
                    s2 = "";
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
