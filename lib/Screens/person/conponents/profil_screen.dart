import 'package:caki_project/Components/constants.dart';
import 'package:caki_project/Screens/BoardView/board_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Main_veiw/main_screen.dart';

class Profil_body extends StatefulWidget {
  const Profil_body({super.key});

  @override
  State<Profil_body> createState() => _Profil_bodyState();
}

class _Profil_bodyState extends State<Profil_body> {
  Map<String, dynamic> _profil_data = {};
  var count;

  @override
  void initState() {
    super.initState();
    _fetchProfil();
  }

  _fetchProfil() async {
    var url = '';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  //backgroundImage: NetworkImage(_profil_data['image_path']),
                ),
                Column(
                  children: [
                    Text(
                      //_profil_data['nickname'],
                      'ssdad',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        //_profil_data['introduce'],
                        'sdd',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 5.0,
            width: double.infinity,
            color: kColor,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '게시글',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            height: 1.0,
            width: double.infinity,
            color: kColor,
          ),
          InkWell(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 1, crossAxisSpacing: 1),
              itemCount: 50,
              itemBuilder: (context, index) => Container(
                color: Colors.grey,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => board_viewer(boardid: 1)), 
              );
            },
          )
        ],
      ),
    );
  }
}
