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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Toggle the switch below to toggle Flashlight"),
          Switch(
              value: _flashOn,
              activeTrackColor: Colors.yellow,
              activeColor: Colors.orangeAccent,
              onChanged: (value) {
                setState(() => {_flashOn = value});
                if (value) {
                  _enableTorch(context);
                } else {
                  _disableTorch(context);
                }
              }),
        ],
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
