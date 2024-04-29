import 'package:caki_project/Screens/search/FilterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchFilterBT extends StatelessWidget {
  const SearchFilterBT({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 눌렀을 때 해당 페이지로 이동하도록 함
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FilterScreen()),
        );
      },
      child: Container( // 둥근 상자
        width: 80,  // 상자 너비
        height: 40,  // 상자 높이
        decoration: BoxDecoration(
          color: Colors.white, // 흰색 바탕
          borderRadius: BorderRadius.circular(10), // 둥근 테두리 설정
          border: Border.all(
            color: Colors.black, // 검은색 테두리
            width: 1.0, // 테두리 두께
          ),
        ),
        alignment: Alignment.center,
        // 텍스트 가운데 정렬
        child: Text(
          '필터',
          textAlign: TextAlign.center, // 텍스트 중앙 정렬
          style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              //fontWeight: FontWeight.bold
          ), // 흰색 텍스트
        ),
      ),
    );
  }
}
