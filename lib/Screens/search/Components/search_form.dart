import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';

List list = [
  "item1",
  "item2",
  "item3",
  "didi",
  "koko",
  "caki",
];

class SearchForm extends StatefulWidget {
  SearchForm({Key? key}) : super(key: key);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return GFSearchBar(
      searchList: list,
      searchQueryBuilder: (query, list) => list.where((item) {
        return item!.toString().toLowerCase().contains(query.toLowerCase());
      }).toList(),
      overlaySearchListItemBuilder: (dynamic item) => Container(
        padding: const EdgeInsets.all(20),
        child: Text(
          item,
          style: const TextStyle(fontSize: 18),
        ),
      ),
      onItemSelected: (dynamic item) {
        setState(() {
          selectedItem = item;
          print('$item');
        });
      },
    );
  }
}
