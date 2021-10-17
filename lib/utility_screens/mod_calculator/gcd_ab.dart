import 'package:flutter/material.dart';

class GcdAb extends StatefulWidget {
  const GcdAb({Key? key}) : super(key: key);

  @override
  _GcdAbState createState() => _GcdAbState();
}

class _GcdAbState extends State<GcdAb> {
  final contA = TextEditingController();
  final contB = TextEditingController();
  int? ans;
  List<String> soln = [];

  calc() {
    int a = int.parse(contA.text);
    int b = int.parse(contB.text);

    if (a < b) {
      int temp = a;
      a = b;
      b = temp;
    }
    ans = null;
    soln = [];
    // algorithm for finding the GCD
    while (a != 0 && b != 0) {
      String s = a.toString() +
          ' = ' +
          (a ~/ b).toString() +
          ' * ' +
          (b).toString() +
          ' + ' +
          (a % b).toString();
      int r = a % b;

      a = b;
      b = r;
      soln.add(s);
    }
    setState(() {
      ans = a;
      soln;
    });
  }

  List<Widget> allSoln() {
    // this function all the elements of the solution contacting one by one
    List<Widget> elem = [];
    if (ans != null) {
      elem.add(const Divider());
      elem.add(Text(
        'GCD (${contA.text} , ${contB.text}) = $ans',
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ));

      for (var i in soln) {
        var e = Text(
          i.toString(),
          style: const TextStyle(fontSize: 20),
        );
        elem.add(e);
      }
    }

    return elem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('GCD(a,b)'),
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
          const SizedBox(height: 30.0,width:double.infinity),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                decoration: const InputDecoration(hintText: 'a',
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
                controller: contA,
              ),
            ),
            const SizedBox(height: 16.0,width:double.infinity),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                decoration: const InputDecoration(hintText: 'b',
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
                controller: contB,
              ),
            ),
            const SizedBox(height: 16.0,width:double.infinity),
            ElevatedButton(onPressed: calc, child: const Text('CALCULATE GCD')),
            ElevatedButton(
                onPressed: () {}, child: const Text('BEZOUT IDENTITY')),
            ElevatedButton(
                onPressed: () {
                  //Clear the text of the both text input fields
                  contA.clear();
                  contB.clear();
                },
                child: const Text('CLEAR')),
            // Solution of the issue is build in this function
            ...allSoln(),
          ],
        ),
      ),
    );
  }
}
