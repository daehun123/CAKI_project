import 'package:flutter/material.dart';

class ArrowTitle extends StatelessWidget {
  final TextEditingController controller;

  const ArrowTitle({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final WTWidth = screenWidth - 20;

    return SizedBox(
      width: WTWidth,
      child: Center(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '레시피 제목',
          ),
        ),
      ),
    );
  }
}
