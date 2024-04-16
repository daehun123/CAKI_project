import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Kategorie/KatSimple_screen.dart';

class KatSimple extends StatelessWidget {
  final double width;
  const KatSimple({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 눌렀을 때 해당 페이지로 이동하도록 함
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SimpleScreen()),
        );
      },
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.black, // 검은색 테두리
            width: 2.0, // 테두리 두께
          ),
        ),
      ),
    );
  }
}