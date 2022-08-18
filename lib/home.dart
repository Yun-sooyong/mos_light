import 'dart:io';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'dart:async';

import 'package:torch_light/torch_light.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

const double width = 300.0;
const double height = 60.0;
const double onAlign = -1;
const double offAlign = 0;
const double blinkAlign = 1;
const Color selectedColor = Colors.white;
const Color unSelectedColor = Colors.black54;

class _HomeState extends State<Home> {
  late double xAlign;
  late Color onColor;
  late Color offColor;
  late Color blinkColor;

  @override
  void initState() {
    super.initState();
    // 앱 실행 시 버튼의 위치, 색
    xAlign = offAlign;
    onColor = unSelectedColor;
    offColor = selectedColor;
    blinkColor = unSelectedColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[400],
      appBar: AppBar(
        title: Text(
          'lumen',
          style: GoogleFonts.bebasNeue(
              fontSize: 50, letterSpacing: 6, color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[600]!,
                offset: const Offset(4, 4),
                blurRadius: 5,
                spreadRadius: 1,
                inset: true,
              ),
              const BoxShadow(
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 10,
                spreadRadius: 1,
                inset: true,
              ),
            ],
          ),
          child: Stack(
            children: [
              // indicator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment(xAlign, 0),
                  child: Container(
                    width: width * 0.28,
                    height: height * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[600],
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(2, 2),
                          blurRadius: 3,
                          spreadRadius: 1,
                          inset: true,
                        ),
                        BoxShadow(
                          color: Colors.grey[600]!,
                          offset: const Offset(-2, -2),
                          blurRadius: 5,
                          spreadRadius: 1,
                          inset: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // on
              GestureDetector(
                onTap: () async {
                  setState(() {
                    xAlign = onAlign;
                    onColor = selectedColor;
                    offColor = unSelectedColor;
                    blinkColor = unSelectedColor;
                  });
                  _turnOnTorch(context);
                },
                child: Align(
                  alignment: const Alignment(-1, 0),
                  child: Container(
                    width: width * 0.33,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'On',
                      style: TextStyle(
                        color: onColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // off
              GestureDetector(
                onTap: () async {
                  setState(() {
                    xAlign = offAlign;
                    onColor = unSelectedColor;
                    offColor = selectedColor;
                    blinkColor = unSelectedColor;
                  });
                  _turnOffTorch(context);
                },
                child: Align(
                  alignment: const Alignment(0, 0),
                  child: Container(
                    width: width * 0.33,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'Off',
                      style: TextStyle(
                        color: offColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    xAlign = blinkAlign;
                    onColor = unSelectedColor;
                    offColor = unSelectedColor;
                    blinkColor = selectedColor;
                  });
                  Timer.periodic(const Duration(seconds: 1), (timer) {
                    _blinkTorch();
                  });
                },
                // blink
                child: Align(
                  alignment: const Alignment(1, 0),
                  child: Container(
                    width: width * 0.33,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'Blink',
                      style: TextStyle(
                        color: blinkColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _blinkTorch() async {
    _turnOnTorch(context);
    sleep(const Duration(milliseconds: 500));
    _turnOffTorch(context);
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
