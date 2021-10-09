

import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class FlashlightScreen extends StatefulWidget {
  const FlashlightScreen({Key? key}) : super(key: key);

  @override
  State<FlashlightScreen> createState() => _FlashlightScreenState();
}

class _FlashlightScreenState extends State<FlashlightScreen> {
  bool _flashOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashlight'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Toggle the switch below to toggle Flashlight",
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 250,
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(300),
                        ),
                        elevation: 50,
                        shadowColor: (_flashOn) ? Colors.white :Colors.transparent
                        ),
                    onPressed: () {
                      if (_flashOn == false) {
                        _enableTorch(context);
                        setState(() {
                          _flashOn = !_flashOn;
                        });
                      } else {
                        _disableTorch(context);
                        setState(() {
                          _flashOn = !_flashOn;
                        });
                      }
                    },
                    child: const Icon(
                      Icons.flashlight_off,
                      size: 150,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _enableTorch(BuildContext context) async {
    try {
      await TorchLight.enableTorch();
    } on Exception catch (_) {
      _showMessage('Could not enable torch', context);
    }
  }

  _disableTorch(BuildContext context) async {
    try {
      await TorchLight.disableTorch();
    } on Exception catch (_) {
      _showMessage('Could not disable torch', context);
    }
  }

  _showMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
