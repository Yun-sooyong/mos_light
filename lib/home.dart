import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isTorchOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('lumen'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blueGrey,
        child: Center(
          child: Column(
            children: [
              IconButton(
                icon: isTorchOn
                    ? const Icon(
                        Icons.flashlight_on_rounded,
                        size: 40,
                        color: Colors.amber,
                      )
                    : const Icon(
                        Icons.flashlight_off_rounded,
                        size: 40,
                      ),
                onPressed: () async {
                  setState(() {
                    isTorchOn = !isTorchOn;
                  });
                  isTorchOn ? _turnOnTorch(context) : _turnOffTorch(context);
                },
              ),
              Row(
                children: [
                  //TODO Button 3 :: 0.5 / 2.0 / 3.0
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _turnOnTorch(BuildContext context) async {
    try {
      await TorchLight.enableTorch();
    } on Exception catch (_) {
      _showMessage('Could not turn on torch', context);
    }
  }

  Future<void> _turnOffTorch(BuildContext context) async {
    try {
      await TorchLight.disableTorch();
    } on Exception catch (_) {
      _showMessage('Could not disable torch', context);
    }
  }

  void _showMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
