import 'package:caki_project/Screens/search/Components/recent_search.dart';
import 'package:caki_project/Screens/search/Components/search_filterBT.dart';
import 'package:caki_project/Screens/search/Components/search_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Main_veiw/Bottom_main.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final WTWidth = (screenWidth - 20);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Color(0xFF8A9352),
          automaticallyImplyLeading: false,
          title: Container(
            alignment: Alignment.centerLeft,
            width: WTWidth,
            child: SearchForm(),
          ), // 검색 입력 폼을 AppBar의 액션으로 추가
        ),
      ),
      body: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Recent_Search(),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Positioned(
                  right: 10,
                  top: 10,
                  child: SearchFilterBT(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}
