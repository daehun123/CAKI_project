import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../Main_veiw/Bottom_main.dart';
import '../Main_veiw/Components/Mainpagesearchbox.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0), // AppBar의 높이 설정
        child: AppBar(
          backgroundColor: Color(0xFF8A9352),
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // 아이콘 설정
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()), // 설정 페이지로 이동
              );
            },
          ),
          bottom: searchBox(context),
        ),
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}
