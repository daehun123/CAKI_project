import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Recent_Search extends StatefulWidget {
  const Recent_Search({Key? key}) : super(key: key);

  @override
  _Recent_SearchState createState() => _Recent_SearchState();
}

class _Recent_SearchState extends State<Recent_Search> {
  List<String> recentSearches = [];

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  Future<void> _loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches = prefs.getStringList('recentSearches') ?? [];
    });
  }

  Future<void> _saveRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('recentSearches', recentSearches);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "최근 검색",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: recentSearches.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(recentSearches[index]),
                onTap: () {
                  // 검색을 수행하거나 검색 결과 화면으로 이동하는 등의 작업 수행
                  // 예: Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResultScreen(query: recentSearches[index])));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}