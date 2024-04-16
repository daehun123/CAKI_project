import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchForm extends StatelessWidget {
  final Search_formkey = GlobalKey<FormState>();

  SearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: Search_formkey,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: TextFormField(
          autofocus: true, // 자동으로 키보드를 띄움
          decoration: InputDecoration(
            hintText: '  검색어를 입력하세요',
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // 검색 버튼 클릭 시 동작할 내용
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0), // 테두리를 둥글게 만듦
            ), // 위아래 여백을 늘림
          ),
          onFieldSubmitted: (value) {
            // 엔터 키나 검색 버튼을 눌렀을 때 동작할 내용
          },
        ),
      ),
    );
  }
}
