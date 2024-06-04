import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../person/Personscreen.dart';


class MainpagePersonbt extends StatefulWidget {
  const MainpagePersonbt({super.key});

  @override
  State<MainpagePersonbt> createState() => _MainpagePersonbtState();
}

class _MainpagePersonbtState extends State<MainpagePersonbt> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 30,
      icon: Column(  // Column을 사용하여 아이콘과 텍스트를 세로로 배치
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, color: Color(0xFF8A9352),), // 다섯 번째 아이콘
          Text('프로필', style: TextStyle(fontSize: 10.0),),
        ],
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PersonScreen()), // 두 번째 화면으로 이동
        );// 아이콘 클릭 시 수행할 동작
      },
    );
  }
}
