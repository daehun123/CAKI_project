import 'package:caki_project/Components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Main_veiw/Bottom_main.dart';
import '../Main_veiw/main_screen.dart';

class ArrowScreen extends StatelessWidget {
  const ArrowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    final screenWidth = MediaQuery.of(context).size.width;
    final WTWidth = (screenWidth - 20);
    return Scaffold(
      appBar: AppBar(
        title: Text('업 로 드'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // 아이콘 설정
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePage()), // 설정 페이지로 이동
            );
          },
        ),
        backgroundColor: Color(0xFF8A9352), // 엡바 색상 설정
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start, // 세로 방향 가운데 정렬
          crossAxisAlignment: CrossAxisAlignment.center, // 가로 방향 가운데 정렬
          children: <Widget>[
            SizedBox(height: 15),
        Container(
          width: WTWidth,
          child: TextField(
            controller: myController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '레시피 제목',
              )
            ),
          ),
      ]),
      bottomNavigationBar: Bottom(),
    );
  }
}
