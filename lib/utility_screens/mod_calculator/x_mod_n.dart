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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('X\u207B\u00B9 MOD N'),
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
          const SizedBox(height: 30.0,width:double.infinity),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                decoration: InputDecoration(hintText: 'X: base',
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
              ),
            ),
            const SizedBox(height: 16.0,width:double.infinity),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                decoration: InputDecoration(hintText: 'n: Modulus',
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
              ),
            ),
          const SizedBox(height: 16.0,width:double.infinity),
            ElevatedButton(
                onPressed: () {}, child: const Text('CALCULATE INVERSE')),
            ElevatedButton(onPressed: () {}, child: const Text('CLEAR')),
          ],
        ),
      ),
    );
  }
}
