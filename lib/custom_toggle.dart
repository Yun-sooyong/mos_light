import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

const double width = 300.0;
const double height = 60.0;
const double loginAlign = -1;
const double lockAlign = 0;
const double signInAlign = 1;
const Color selectedColor = Colors.white;
const Color normalColor = Colors.black54;

class _ToggleButtonState extends State<ToggleButton> {
  late double xAlign;
  late Color loginColor;
  late Color signInColor;
  late Color offColor;

  @override
  void initState() {
    super.initState();
    xAlign = lockAlign;
    loginColor = normalColor;
    signInColor = normalColor;
    offColor = selectedColor;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: Alignment(xAlign, 0),
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: width * 0.33,
                height: height,
                decoration: const BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  xAlign = loginAlign;
                  loginColor = selectedColor;
                  signInColor = normalColor;
                  offColor = normalColor;
                });
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
                      color: loginColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  xAlign = lockAlign;
                  loginColor = normalColor;
                  signInColor = normalColor;
                  offColor = selectedColor;
                });
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
                  xAlign = signInAlign;
                  signInColor = selectedColor;
                  loginColor = normalColor;
                  offColor = normalColor;
                });
              },
              child: Align(
                alignment: const Alignment(1, 0),
                child: Container(
                  width: width * 0.33,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    'Blink',
                    style: TextStyle(
                      color: signInColor,
                      fontWeight: FontWeight.bold,
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
}
