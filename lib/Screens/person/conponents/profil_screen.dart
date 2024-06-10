import 'package:caki_project/Components/constants.dart';
import 'package:caki_project/Screens/BoardView/board_view_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import '../../Main_veiw/main_screen.dart';
import '../../Welcome/welcome_screen.dart';
import '../../splash_screen.dart';

class Profil_body extends StatefulWidget {
  const Profil_body({super.key});

  @override
  State<Profil_body> createState() => _Profil_bodyState();
}

class _Profil_bodyState extends State<Profil_body> {
  List<dynamic> _profil_data = [];
  bool isLoading = true;
  var count;
  static const storage = FlutterSecureStorage();
  final ImagePicker picker = ImagePicker();
  XFile? image;
  final List<XFile?> pickedImages = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _fetchProfil();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _fetchProfil() async {
    String? nickname = await storage.read(key: 'nickname');
    print(nickname);
    var url = 'http://13.124.205.29/$nickname/';
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
          _profil_data = [response.data];
          print(_profil_data);
        });
      } else if (response.statusCode == 401) {
        try {
          response = await dio.get(
            'http://13.124.205.29/token/refresh/',
            options: Options(
              headers: {'Authorization': 'Bearer $refresh_token'},
            ),
          );
          setState(() {
            access_token = response.data['access_token'];
            storage.delete(key: 'jwt_accessToken');
            storage.write(key: 'jwt_accessToken', value: access_token);
          });
          _fetchProfil();
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
      print('error');
    }
  }

  // Future<String> getBase64Image(XFile image) async {
  //   List<String> base64Images = [];
  //   List<int> bytes = await image.readAsBytes();
  //   String base64Image = base64Encode(bytes);
  //   String extension = image.path.split('.').last;
  //   base64Images.add('data:image/$extension;base64,$base64Image');
  //
  // }
  Future<void> _chageimage() async {
    String? nickname = await storage.read(key: 'nickname');
    print(nickname);
    var url = 'http://13.124.205.29/$nickname/';
    var dio = Dio();
    String? access_token = await storage.read(key: 'jwt_accessToken');
    String? refresh_token = await storage.read(key: 'jwt_refreshToken');

    try {
      var formData = FormData.fromMap({
        'image':
            await MultipartFile.fromFile(image!.path, filename: image!.name),
      });

      print(formData.fields);
      var response = await dio.put(
        url,
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $access_token'},
        ),
      );
      if (response.statusCode == 200) {
        print(access_token);
        var access_token_change = response.data['access_token'];
        print(access_token);
        var refresh_token = response.data['refresh_token'];
        await storage.delete(key: 'jwt_accessToken');
        await storage.delete(key: 'jwt_refreshToken');
        await storage.write(key: 'jwt_refreshToken', value: refresh_token);
        await storage.write(key: 'jwt_accessToken', value: access_token_change);
        setState(() {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('변경 완료'),
                content: Text('프로필 사진이 변경되었습니다.'),
                actions: <Widget>[
                  TextButton(
                    child: Text('확인'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        });
      } else if (response.statusCode == 401) {
        try {
          response = await dio.get(
            'http://13.124.205.29/token/refresh/',
            options: Options(
              headers: {'Authorization': 'Bearer $refresh_token'},
            ),
          );
          setState(() {
            access_token = response.data['access_token'];
            storage.delete(key: 'jwt_accessToken');
            storage.write(key: 'jwt_accessToken', value: access_token);
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
      print('error');
    }
  }

  void getImage(ImageSource source) async {
    image = await picker.pickImage(source: source);

    setState(() {
      _chageimage();
    });
  }

  Future<void> _delete_image() async {
    var url = 'http://13.124.205.29/defult_image/';
    var dio = Dio();
    String? access_token = await storage.read(key: 'jwt_accessToken');
    try {
      var response = await dio.get(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer $access_token'},
        ),
      );
      if(response.statusCode == 200){
        setState(() {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('변경 완료'),
                content: Text('프로필 사진이 변경되었습니다.'),
                actions: <Widget>[
                  TextButton(
                    child: Text('확인'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Spalsh_Screen()
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        _profil_data[0]['profile_info']['image_url'] != null
                            ? InkWell(
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                    _profil_data[0]['profile_info']
                                        ['image_url'],
                                  ),
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 130),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    print('press');
                                                    getImage(
                                                        ImageSource.gallery);
                                                  },
                                                  child: Text('변경')),
                                              TextButton(
                                                  onPressed: () {
                                                    _delete_image();
                                                  },
                                                  child: Text(
                                                    '삭제',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ))
                                            ],
                                          ),
                                        );
                                      });
                                },
                              )
                            : InkWell(
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      AssetImage('assets/Img/userprofil.jpg'),
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 130),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    print('press');
                                                    getImage(
                                                        ImageSource.gallery);
                                                  },
                                                  child: Text('변경')),
                                              TextButton(
                                                  onPressed: () {
                                                    _delete_image();
                                                  },
                                                  child: Text(
                                                    '삭제',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ))
                                            ],
                                          ),
                                        );
                                      });
                                },
                              ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _profil_data[0]['profile_info']['nickname'],
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                  _profil_data[0]['profile_info']['qual'] != 0
                                      ? const Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Icon(
                                            Icons.verified,
                                            color: Colors.lightBlue,
                                            size: 18,
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                              _profil_data[0]['profile_info']['introduce'] !=
                                      null
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40),
                                      child: Text(
                                        _profil_data[0]['profile_info']
                                            ['introduce'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40)),
                            ],
                          ),
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
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1),
                    itemCount: _profil_data[0]['post_list'].length,
                    itemBuilder: (context, index) => InkWell(
                      child: Image.network(
                        _profil_data[0]['post_list'][index]['post_image'][0],
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => board_viewer(
                                  boardid: _profil_data[0]['post_list'][index]
                                      ['post_id'])),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
