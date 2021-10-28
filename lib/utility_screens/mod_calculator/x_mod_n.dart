import 'package:flutter/material.dart';

class XModN extends StatefulWidget {
  const XModN({Key? key}) : super(key: key);

  @override
  _XModNState createState() => _XModNState();
}

class _XModNState extends State<XModN> {
  final contX = TextEditingController();
  final contN = TextEditingController();
  String? ans;
  int x = 0, n = 0;
  String modInverse() {
    int a = int.parse(contX.text);
    int m = int.parse(contN.text);
    int m0 = m;
    int y = 0, x = 1;

    if (m == 1) return "0";
    if (a.gcd(m) != 1) return "Doesn't Exist";
    while (a > 1) {
      // q is quotient
      int q = a ~/ m;
      int t = m;
      m = a % m;
      a = t;
      t = y;

      // Update y and x
      y = x - q * y;
      x = t;
    }

    // Make x positive
    if (x < 0) x += m0;

    return x.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('X\u207B\u00B9 MOD N'),
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30.0, width: double.infinity),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'X: base',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(23, 195, 178, 100),
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
                keyboardType: TextInputType.number,
                controller: contX,
              ),
            ),
            const SizedBox(height: 16.0, width: double.infinity),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'n: Modulus',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(23, 195, 178, 100),
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
                keyboardType: TextInputType.number,
                controller: contN,
              ),
            ),
            const SizedBox(height: 16.0, width: double.infinity),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    x = int.parse(contX.text);
                    n = int.parse(contN.text);
                    ans = modInverse();
                  });
                },
                child: const Text('CALCULATE INVERSE')),
            ElevatedButton(
                onPressed: () {
                  contN.clear();
                  contX.clear();
                },
                child: const Text('CLEAR')),
            if (ans != null)
              Column(
                children: [
                  const Text(
                    "Inverse:",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  int.tryParse(ans!) != null
                      ? Text(
                          "• $x\u207B\u00B9 (MOD $n) ≡ $ans\n• $ans × $x ≡ 1(MOD $n)",
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        )
                      : Text(ans!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          )),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
