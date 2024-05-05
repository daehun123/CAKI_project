import 'package:caki_project/Components/constants.dart';
import 'package:caki_project/Screens/Main_veiw/main_screen.dart';
import 'package:caki_project/Screens/person/conponents/profil_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Main_veiw/Bottom_main.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // 아이콘 설정
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()), // 설정 페이지로 이동
            );
          },
        ),
        backgroundColor: kColor,
      ),
      body: Profil_body(),
    bottomNavigationBar: Bottom(),
    );
  }
}
