import 'dart:convert';

import 'package:caki_project/Screens/BoardView/board_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BoardList_classic extends StatefulWidget {
  const BoardList_classic({super.key});

  @override
  State<BoardList_classic> createState() => _BoardListState();
}

class _BoardListState extends State<BoardList_classic> {
  List<dynamic> _board_data = [];

  @override
  void initState() {
    super.initState();
    _fetchBoard();
  }

  _fetchBoard() async {
    final response =
        await http.get(Uri.parse('http://13.124.205.29/main/classic/'));
    if (response.statusCode == 200) {
      _board_data = json.decode(response.body);
    } else {
      throw Exception('Fail');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: _board_data.length,
          itemBuilder: (BuildContext context, int index) {
            var item = _board_data[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => board_viewer(boardid: item['idpost'])));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black,
                    maximumSize: const Size(double.infinity, 100),
                    minimumSize: const Size(double.infinity, 100),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.network(
                        item['post_image'][0],
                        fit: BoxFit.fill,
                        width: 100,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Text(item['post_title']),
                      const Spacer(
                        flex: 1,
                      ),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}
