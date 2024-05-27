import 'dart:convert';

import 'package:caki_project/Components/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Main_veiw/Bottom_main.dart';
import '../Welcome/welcome_screen.dart';

class board_viewer extends StatefulWidget {
  const board_viewer({super.key, required this.boardid});

  final int boardid;

  @override
  State<board_viewer> createState() => _board_viewerState();
}

class _board_viewerState extends State<board_viewer> {
  List<dynamic> _board_data = [];
  static const storage = FlutterSecureStorage();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(/*_board_data[0]['post_body']['title']*/'제목'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: kColor,
      ),
      body: Text('hi'),
      bottomNavigationBar: Bottom(),
    );
  }
}
