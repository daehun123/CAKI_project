import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeeklyBTblank extends StatelessWidget {
  const WeeklyBTblank({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10, // 원형 박스 너비
      height: 10, // 원형 박스 높이
      decoration: BoxDecoration(
        color: Colors.white, // 원형 박스 색상
        shape: BoxShape.circle, // 원형 모양
        border: Border.all(
          color: Colors.black, // 검은색 테두리
          width: 1.0, // 테두리 두께
        ),
      ),
      margin: EdgeInsets.all(5),
    );
  }
}
