import 'package:caki_project/Screens/search/Search_Resultscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class SearchForm extends StatefulWidget {
  SearchForm({Key? key}) : super(key: key);
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  String? selectedItem;

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
            ),
            onChanged: (value) {
              setState(() {
                selectedItem = value;
              });
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            if (selectedItem == null || selectedItem!.isEmpty) {
              // 검색어가 비어 있을 때 사용자에게 알림 표시
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('주의', style: TextStyle(color: Colors.red)),
                  content: Text('검색어를 입력하세요.',style: TextStyle(color: Colors.red)),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('확인'),
                    ),
                  ],
                ),
              );
            } else {
              // 검색어가 있는 경우에만 결과 화면으로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultScreen(selectedItem: selectedItem),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
