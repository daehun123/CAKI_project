import 'dart:convert';

import 'package:caki_project/Components/constants.dart';
import 'package:caki_project/Components/location.dart';
import 'package:caki_project/Components/mainprovider.dart';
import 'package:caki_project/Screens/person/Personscreen.dart';
import 'package:caki_project/Screens/person/another_profil.dart';
import 'package:caki_project/Screens/splash_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

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
  bool like = false;
  bool bookmark = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await hook();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> hook() async {
    var url =
        'http://13.124.205.29/postview/' + widget.boardid.toString() + '/';
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
        print(response.data['user_info']);
        setState(() {
          _board_data = [response.data];
          bookmark = _board_data[0]['post_info']['keep']['exists'];
          like = _board_data[0]['post_info']['like']['exists'];
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
            _board_data = [response.data];
            bookmark = _board_data[0]['post_info']['keep']['exists'];
            like = _board_data[0]['post_info']['like']['exists'];
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

  Future<void> _update_like(bool exists) async {
    final provider = Provider.of<MainProvider>(context, listen: false);
    final main_Location = provider.location;
    double? nx = double.tryParse(main_Location.latitude.toString());
    double? ny = double.tryParse(main_Location.longitude.toString());
    var queryParams = {
      'nx': nx?.toStringAsFixed(0) ?? '0',
      'ny': ny?.toStringAsFixed(0) ?? '0'
    };
    var queryString = Uri(queryParameters: queryParams).query;
    var url = 'http://13.124.205.29/like/${widget.boardid}/?$queryString';
    var dio = Dio();
    String? access_token = await storage.read(key: 'jwt_accessToken');
    String? refresh_token = await storage.read(key: 'jwt_refreshToken');
    print(url);
    try {
      var response = await dio.get(url,
          data: {'exists': exists},
          options: Options(headers: {'Authorization': 'Bearer $access_token'}));
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          like = exists;
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
          await dio.post(
            url,
            options: Options(
              headers: {'Authorization': 'Bearer $access_token'},
            ),
          );
          setState(() {
            like = exists;
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
        var reresponse = await dio.get(url,
            data: {'exists': exists},
            options:
                Options(headers: {'Authorization': 'Bearer $access_token'}));
        print(reresponse.statusCode);
        if (reresponse.statusCode == 200) {
          setState(() {
            like = exists;
          });
        }
      }
    } catch (e) {
      print('error');
    }
  }

  Future<void> _update_bookmark(bool exists) async {
    var url = 'http://13.124.205.29/keep/' + widget.boardid.toString() + '/';
    var dio = Dio();
    String? access_token = await storage.read(key: 'jwt_accessToken');
    String? refresh_token = await storage.read(key: 'jwt_refreshToken');

    try {
      var response = await dio.get(url,
          data: {'keep_exists': exists},
          options: Options(headers: {'Authorization': 'Bearer $access_token'}));
      if (response.statusCode == 200) {
        setState(() {
          bookmark = exists;
        });
      } else if (response.statusCode == 401) {
        try {
          response = await dio.get(
            url,
            data: {'keep_exists': exists},
            options: Options(
              headers: {'Authorization': 'Bearer $refresh_token'},
            ),
          );
          setState(() {
            bookmark = exists;
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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Spalsh_Screen()
        : Scaffold(
            appBar: AppBar(
              title: Text(_board_data[0]['post_info']['title']),
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
                            _board_data[0]['post_info']['image'].isNotEmpty
                        ? Image.network(
                            _board_data[0]['post_info']['image'][0],
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
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Row(
                      children: [
                        _board_data[0]['post_info']['writer']['image'] != null
                            ? CircleAvatar(
                                radius: 15,
                                backgroundImage:
                                    AssetImage('assets/Img/userprofil.jpg'),
                              )
                            : CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(_board_data[0]
                                    ['post_info']['writer']['image']),
                              ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Another_Profil(
                                        user_name: _board_data[0]['post_info']
                                            ['writer']['nickname'],
                                      )),
                            );
                          },
                          child: Text(
                            _board_data[0]['post_info']['writer']['nickname'],
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
                            like ? Icons.favorite : Icons.favorite_border,
                            color: like ? Colors.red : null,
                          ),
                          onPressed: () {
                            setState(() {
                              _update_like(!like);
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            bookmark ? Icons.bookmark : Icons.bookmark_border,
                            color: bookmark ? kColor : null,
                          ),
                          onPressed: () {
                            setState(() {
                              _update_bookmark(!bookmark);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 2.0,
                            children: _board_data.isNotEmpty
                                ? _board_data[0]['post_info']['tag']
                                    .map<Widget>((tag) {
                                    return Chip(
                                      labelPadding: EdgeInsets.all(2.0),
                                      label: Text(
                                        '#$tag',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                      backgroundColor: Colors.grey[300],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                    );
                                  }).toList()
                                : [],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 5.0,
                    width: double.infinity,
                    color: kColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '재료',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          _board_data[0]['post_info']['ingredients'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '- ${_board_data[0]['post_info']['ingredients'][index]}',
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
                    child: Text('조주법', style: TextStyle(fontSize: 17)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            Text(
                              '- ${_board_data[0]['post_info']['body']}',
                              style: TextStyle(fontSize: 16.0),
                              maxLines: null,
                              overflow: TextOverflow.visible,
                            ),
                          ],
                        ),
                        Container(
                          height: 1.0,
                          width: double.infinity,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _board_data[0]['post_info']['image'].length > 1
                        ? SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  _board_data[0]['post_info']['image'].length -
                                      1,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            child: InteractiveViewer(
                                              panEnabled: false,
                                              boundaryMargin:
                                                  EdgeInsets.all(20),
                                              minScale: 0.5,
                                              maxScale: 2,
                                              child: Image.network(
                                                _board_data[0]['post_info']
                                                    ['image'][index + 1],
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Image.network(
                                      _board_data[0]['post_info']['image']
                                          [index + 1],
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Bottom(),
          );
  }
}
