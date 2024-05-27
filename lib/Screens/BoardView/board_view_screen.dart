import 'dart:convert';

import 'package:caki_project/Components/constants.dart';
import 'package:caki_project/Screens/person/Personscreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Main_veiw/Bottom_main.dart';
import '../Welcome/welcome_screen.dart';

// @override
// void initState() {
//   super.initState();
//   hook();
// }
//
// Future<void> hook() async {
//   var url = 'http://13.124.205.29/postview/' + widget.boardid.toString();
//   var dio = Dio();
//   String? access_token = await storage.read(key: 'jwt_accessToken');
//   String? refresh_token = await storage.read(key: 'jwt_refreshToken');
//
//   try {
//     var response = await dio.get(
//       url,
//       options: Options(
//         headers: {'Authorization': 'Bearer $access_token'},
//       ),
//     );
//     if (response.statusCode == 200) {
//       setState(() {
//         _board_data = jsonDecode(response.data);
//       });
//     } else if (response.statusCode == 401) {
//       try{
//         response = await dio.get(
//           url,
//           options: Options(
//             headers: {'Authorization': 'Bearer $refresh_token'},
//           ),
//         );
//         setState(() {
//           _board_data = jsonDecode(response.data);
//         });
//       }catch(e){
//         print('로그아웃 해');
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('토큰 만료'),
//               content: Text('다시 로그인 해주세요.'),
//               actions: <Widget>[
//                 TextButton(
//                   child: Text('확인'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(
//                             builder: (BuildContext context) =>
//                             const Welcome_Screen()),
//                             (route) => false);
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     }
//   } catch (e) {
//     print('error');
//   }
// }
class board_viewer extends StatefulWidget {
  const board_viewer({super.key, required this.boardid});

  final int boardid;

  @override
  State<board_viewer> createState() => _board_viewerState();
}

class _board_viewerState extends State<board_viewer> {
  List<dynamic> _board_data = [];
  static const storage = FlutterSecureStorage();
  List<String> ingredients = [    '재료1',    '재료2',    '재료3',    '재료4',    '재료5',  ];
  List<String> instructions = [    '만드는 법 1',    '만드는 법 2',    '만드는 법 3',    '만드는 법 4',    '만드는 법 5',  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(/*_board_data[0]['post_body']['title']*/ '제목'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: kColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child: _board_data.isNotEmpty &&
                      _board_data[0]['post_image'].isNotEmpty
                  ? Image.network(
                      _board_data[0]['post_image'][0],
                      fit: BoxFit.cover,
                    )
                  : Container(
                      child: Center(child: Text('key_picture')),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8,8,8,0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage:
                        NetworkImage("https://via.placeholder.com/150"),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PersonScreen()),
                      );
                    },
                    child: Text(
                      'writer',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.verified,
                    color: Colors.lightBlue,
                    size: 18,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  IconButton(
                    icon: Icon(
                      true ? Icons.favorite : Icons.favorite_border,
                      color: true ? Colors.red : null,
                    ),
                    onPressed: () {
                      setState(() {
                        //서버 요청
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      false ? Icons.bookmark : Icons.bookmark_border,
                      color: false ? kColor : null,
                    ),
                    onPressed: () {
                      setState(() {
                        //변경점 서버 요청
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 2.0,
                    children: [
                      Chip(
                        labelPadding: EdgeInsets.all(2.0),
                        label: Text('#도수1',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            )),
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0), // 모서리 반지름 증가
                        ),
                      ),
                      Chip(
                        labelPadding: EdgeInsets.all(2.0),
                        label: Text('#당도3',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            )),
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0), // 모서리 반지름 증가
                        ),
                      ),
                      Chip(
                        labelPadding: EdgeInsets.all(2.0),
                        label: Text('#데킬라',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            )),
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0), // 모서리 반지름 증가
                        ),
                      ),
                      Chip(
                        labelPadding: EdgeInsets.all(2.0),
                        label: Text('#리큐르',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            )),
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0), // 모서리 반지름 증가
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('재료',style: TextStyle(fontSize: 17),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '- ${ingredients[index]}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Container(
                          height: 1.0,
                          width: double.infinity,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 5.0,
              width: double.infinity,
              color: kColor,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('조주법',style: TextStyle(fontSize: 17)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: instructions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '- ${instructions[index]}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Container(
                          height: 1.0,
                          width: double.infinity,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}
