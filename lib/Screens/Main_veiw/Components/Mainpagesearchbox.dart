import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../search/Searchscreen.dart';

@override
PreferredSizeWidget searchBox(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(55.0),
    child: Container(
      padding: EdgeInsets.all(20.0),
      child: Stack(
        children: [
          ElevatedButton(
            onPressed: () {
              // 버튼이 클릭되었을 때 원하는 페이지로 이동하는 코드를 추가하세요.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.black, width: 1.0),
              ),
              padding: EdgeInsets.zero,
            ),
            child: Container(
              width: double.infinity,
              height: 35.0,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  SizedBox(width: 5),
                  Text(
                    '검색',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
