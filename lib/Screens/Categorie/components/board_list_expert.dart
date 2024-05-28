import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../BoardView/board_view_screen.dart';
import '../../Welcome/welcome_screen.dart';

class BoardList_expert extends StatefulWidget {
  const BoardList_expert({super.key});

  @override
  State<BoardList_expert> createState() => _BoardListState();
}

class _BoardListState extends State<BoardList_expert> {
  List<dynamic> _board_data = [];
  static const storage = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    _fetchBoard();
  }

  _fetchBoard() async {
    var url = 'http://13.124.205.29/main/expert/';
    var dio = Dio();
    String? access_token = await storage.read(key: 'jwt_accessToken');
    String? refresh_token = await storage.read(key: 'jwt_refreshToken');

    try {
      var response = await dio.get(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer $access_token'},
        ),
      );
      if (response.statusCode == 200) {
        setState(() {
          if (response.data is List) {
            _board_data = response.data;
          } else if (response.data is Map) {
            _board_data = (response.data['post_list'] as List).cast<dynamic>();
          } else {
            print('Response data is not a List or Map');
          }
        });
      } else if (response.statusCode == 401) {
        try {
          response = await dio.get(
            url,
            options: Options(
              headers: {'Authorization': 'Bearer $refresh_token'},
            ),
          );
          setState(() {
            _board_data = jsonDecode(response.data);
          });
        } catch (e) {
          print('로그아웃 해');
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('토큰 만료'),
                content: Text('다시 로그인 해주세요.'),
                actions: <Widget>[
                  TextButton(
                    child: Text('확인'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                              const Welcome_Screen()),
                              (route) => false);
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      print('error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height*(4/5),
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
                            builder: (context) =>
                                board_viewer(boardid: item['post_id'])));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black,
                    maximumSize: const Size(double.infinity, 100),
                    minimumSize: const Size(double.infinity, 100),
                  ),
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          item['post_image'][0],
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                      ),
                      // const Spacer(
                      //   flex: 1,
                      // ),
                      SizedBox(width: 50,),
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 130,),
                              Text(item['writer_nickname']),
                            ],
                          ),
                          Spacer(flex: 1,),
                          Text(item['post_title'],style: TextStyle(fontSize: 22),),
                          Spacer(flex: 1,),
                          Row(
                            children: [
                              Row(
                                children: [
                                  if (item['post_tag'].isNotEmpty)
                                    for (int i = item['post_tag'].length - 2; i < item['post_tag'].length; i++)
                                      i < item['post_tag'].length - 1
                                          ? Text('#' + item['post_tag'][i] + ' ')
                                          : Text('#' + item['post_tag'][i]),
                                ],
                              ),
                              SizedBox(width: 40,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.favorite,color: Colors.red,size: 20,),
                                  Text(item['post_like'].toString()),
                                ],
                              )
                            ],
                          ),

                        ],
                      ),
                      // const Spacer(
                      //   flex: 1,
                      // ),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}
