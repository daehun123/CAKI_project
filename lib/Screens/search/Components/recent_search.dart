import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Search_Resultscreen.dart';

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
    _loadSearchHistory();
  }

  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches = prefs.getStringList('searchHistory') ?? [];
    });
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(selectedItem: recentSearches[index]),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
