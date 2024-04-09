import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}
