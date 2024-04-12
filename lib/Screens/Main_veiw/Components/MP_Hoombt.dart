import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';

class MainpageHoombt extends StatelessWidget {
  const MainpageHoombt({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 30,
      icon: Column(  // Column을 사용하여 아이콘과 텍스트를 세로로 배치
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, color: Color(0xFF8A9352),), // 세 번째 아이콘
          Text('홈', style: TextStyle(fontSize: 10.0),),
        ],
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()), // 두 번째 화면으로 이동
        );// 아이콘 클릭 시 수행할 동작
      },
    );
  }
}
