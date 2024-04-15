import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Main_veiw/Bottom_main.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF8A9352),
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // 검색 아이콘 클릭 시 동작할 내용
              },
            ),
            Text(
              '검색',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('여기에 검색 내용이 표시됩니다.'),
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}
