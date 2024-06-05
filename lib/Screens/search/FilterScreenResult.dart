import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterResultScreen extends StatelessWidget {
  final List<String> selectedKeywords; // 선택된 키워드 리스트를 받음

  const FilterResultScreen({Key? key, required this.selectedKeywords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'Selected Keywords:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              selectedKeywords.isNotEmpty ? selectedKeywords.join(", ") : 'None', // 선택된 키워드 출력
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}


