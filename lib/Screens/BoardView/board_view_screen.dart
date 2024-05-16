import 'package:caki_project/Components/constants.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class board_viewer extends StatefulWidget {
  const board_viewer({super.key});

  @override
  State<board_viewer> createState() => _board_viewerState();
}

class _board_viewerState extends State<board_viewer> {
  List<dynamic> _board_data = [];

  @override
  void initState() {
    super.initState();
    _fetchBoard();
  }

  _fetchBoard() async {
    final response = await http.get(Uri.parse('uri'));
    if (response.statusCode == 200) {
      setState(() {
        _board_data = json.decode(response.body);
      });
    } else {
      throw Exception('Fail');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_board_data[0]['title']),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: kColor,
      ),
    );
  }
}
