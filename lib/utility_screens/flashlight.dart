import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class FlashlightScreen extends StatefulWidget {
  const FlashlightScreen({Key? key}) : super(key: key);

  @override
  State<FlashlightScreen> createState() => _FlashlightScreenState();
}

class _FlashlightScreenState extends State<FlashlightScreen> {
  bool _flashOn = false;
  String on = "Click on Button to switch on",
      off = "Click on Button to switch off";

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: 250,
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(300),
                        ),
                        elevation: 150,
                        shadowColor: (_flashOn) ? Colors.white : Colors.grey),
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
                    child: _flashOn == true
                        ? const Icon(
                            Icons.flashlight_off,
                            size: 150,
                          )
                        : const Icon(
                            Icons.flashlight_on,
                            size: 150,
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                _flashOn ? off : on,
                style: const TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ]),
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
