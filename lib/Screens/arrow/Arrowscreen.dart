import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Main_veiw/Bottom_main.dart';
import '../Main_veiw/main_screen.dart';

class ArrowScreen extends StatelessWidget {
  const ArrowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('업로드'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // 아이콘 설정
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()), // 설정 페이지로 이동
            );
          },
        ),
        backgroundColor: Color(0xFF8A9352), // 엡바 색상 설정
      ),
      body: Center(
        child: Text('이것은 두 번째 화면입니다.'),
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}
