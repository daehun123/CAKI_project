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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "   최근 검색",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}