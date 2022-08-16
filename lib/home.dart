import 'package:flutter/material.dart';
import 'package:mos_light/custom_toggle.dart';
import 'package:torch_light/torch_light.dart';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<bool> isSelected = [false];
  bool isTorchOn = false;
  //Timer _timer;

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
        //width: double.infinity,
        //height: double.infinity,
        color: Colors.blueGrey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToggleButton(),
              Text(
                '$isTorchOn',
                style: TextStyle(
                    fontSize: 25,
                    color: isTorchOn ? Colors.white : Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void blinkTorch(int time) {
    //_showMessage('$isTorchOn', context);
    @override
    void initState() {
      super.initState();
      _turnOnTorch(context);
    }

    Timer.periodic(Duration(seconds: time), (timer) {
      _turnOffTorch(context);
      Timer(const Duration(seconds: 1), () {
        _turnOnTorch(context);
      });
    });
  }

  Future<void> _turnOnTorch(BuildContext context) async {
    try {
      await TorchLight.enableTorch();
      print('on');
    } on Exception catch (_) {
      //_showMessage('Could not turn on torch', context);
    }
  }

  Future<void> _turnOffTorch(BuildContext context) async {
    try {
      await TorchLight.disableTorch();
      print('off');
    } on Exception catch (_) {
      //_showMessage('Could not disable torch', context);
    }
  }

  void _showMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
