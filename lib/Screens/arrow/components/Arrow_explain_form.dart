import 'package:flutter/material.dart';

class ArrowExplain extends StatelessWidget {
  const ArrowExplain({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50, // 원하는 높이로 설정
      child: TextField(
        decoration: InputDecoration(
          hintText: '레시피 설명 추가'
        ),
      ),
    );
  }
}
