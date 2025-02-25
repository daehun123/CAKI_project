import 'package:caki_project/Screens/Main_veiw/main_screen.dart';
import 'package:caki_project/Screens/keep/keep_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Main_veiw/Bottom_main.dart';

class KeepScreen extends StatelessWidget {
  const KeepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('킵'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // 아이콘 설정
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()), // 설정 페이지로 이동
            );
          },
        ),
        backgroundColor: Color(0xFF8A9352),
      ),
      body: const BoardList_keep(),
      bottomNavigationBar: Bottom(),
    );
  }
}
