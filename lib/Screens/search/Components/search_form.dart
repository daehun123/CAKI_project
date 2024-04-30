import 'package:caki_project/Screens/search/Search_Resultscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchForm extends StatelessWidget {
  final searchFormKey = GlobalKey<FormState>();

  SearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: searchFormKey,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: TextFormField(
          textInputAction: TextInputAction.next,
          autofocus: true, // 자동으로 키보드를 띄움
          validator: (value) {
            if (value == null || value.isEmpty) {
              return;
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: '  검색어를 입력하세요',
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // 폼 검증
                if (searchFormKey.currentState!.validate()) {
                  // 검증 성공 시 ResultScreen으로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResultScreen()),
                  );
                }
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