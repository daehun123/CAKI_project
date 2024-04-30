import 'package:caki_project/Screens/search/Search_Resultscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchForm extends StatelessWidget {

  SearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchBar(
      trailing: [Icon(Icons.search)],
      hintText: "검색어를 입력하세요",
    );
  }
}