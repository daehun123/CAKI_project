import 'package:flutter/material.dart';

class Welcome_Image extends StatelessWidget {
  const Welcome_Image({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "WELCOME TO CAKI",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 32.0),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset(
                'asset/img/intro_under.png',
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 32.0),
      ],
    );
  }
}
