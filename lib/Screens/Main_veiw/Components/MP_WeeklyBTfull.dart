import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeeklyBTfull extends StatelessWidget {
  const WeeklyBTfull({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10, // 원형 박스 너비
      height: 10, // 원형 박스 높이
      decoration: BoxDecoration(
        color: Colors.black, // 원형 박스 색상
        shape: BoxShape.circle, // 원형 모양
      ),
      margin: EdgeInsets.all(5),
    );
  }
}
