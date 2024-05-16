import 'package:caki_project/Components/constants.dart';
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
  String? accessToken;

  @override
  void initState() {
    super.initState();
    _fetchProfil();
  }

  _fetchProfil() async {
    final response = await http.get(Uri.parse('http://13.124.205.29/'));
    if (response.statusCode == 200) {
      setState(() {
        _profil_data = json.decode(response.body);
      });
    } else {
      throw Exception('Fail');
    }
    // _profil_data = {
    //   "name": "대훈",
    //   "bio": "소프트웨어학과 파이팅",
    //   "imageUrl": "https://via.placeholder.com/150",
    //   "posts": Null
    // };
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
                  backgroundImage: NetworkImage(_profil_data['imageUrl']),
                ),
                Column(
                  children: [
                    Text(
                      _profil_data['name'],
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        _profil_data['bio'],
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
                MaterialPageRoute(builder: (context) => MyHomePage()), // 설정 페이지로 이동
              );
            },
          )
        ],
      ),
    );
  }
}
