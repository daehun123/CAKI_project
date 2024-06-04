import 'package:caki_project/Components/constants.dart';
import 'package:caki_project/Screens/splash_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../BoardView/board_view_screen.dart';
import '../Main_veiw/Bottom_main.dart';
import '../Welcome/welcome_screen.dart';

class Trend_list extends StatefulWidget {
  const Trend_list({super.key, required this.nx, required this.ny, required this.recommend});

  final double nx;
  final double ny;
  final String? recommend;

  @override
  State<Trend_list> createState() => _Trend_listState();
}

class _Trend_listState extends State<Trend_list> {
  static const storage = FlutterSecureStorage();
  List<dynamic> _list = [];
  String title = '';

  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadDate();
    _setTitle();
  }

  void _setTitle() {
    switch (widget.recommend) {
      case 'post_by_like':
        title = '좋아요순 추천';
        break;
      case 'post_by_like':
        title = '요일별 추천';
        break;
      case 'post_by_weather':
        title = '날씨별 추천';
        break;
      case 'post_by_ranking':
        title = '취향별 추천';
        break;
      default:
        title = '오늘의 추천';
    }
  }

  Future<void> _loadDate() async{
    await shareLocation();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> shareLocation() async {


    var queryParams = {
      'nx': widget.nx.toStringAsFixed(0),
      'ny': widget.ny.toStringAsFixed(0)
    };
    var queryString = Uri(queryParameters: queryParams).query;
    var url = 'http://13.124.205.29/main?$queryString';
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
        _list = [response.data];
        print(_list);
      } else if (response.statusCode == 401) {
        try {
          response = await dio.get(
            url,
            options: Options(
              headers: {'Authorization': 'Bearer $refresh_token'},
            ),
          );
          if(response.statusCode == 200){
            _list = [response.data];
            print(_list);
          }
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
      return isLoading ? Spalsh_Screen() : Scaffold(
        appBar: AppBar(
          title: Text(title,),
          backgroundColor: kColor,
        ),
        body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * (4 / 5),
          child: ListView.builder(
            itemCount: _list[0]['weekly_trends'][widget.recommend].length,
            itemBuilder: (BuildContext context, int index) {
              var item = _list[0]['weekly_trends'][widget.recommend][index];
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
                        SizedBox(
                          width: 50,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // SizedBox(
                                  //   width: 130,
                                  // ),
                                  Text(item['writer_nickname']),
                                ],
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Text(
                                item['post_title'],
                                style: const TextStyle(fontSize: 22),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      if (item['post_tag'].isNotEmpty)
                                        for (int i = item['post_tag'].length - 2;
                                        i < item['post_tag'].length;
                                        i++)
                                          i < item['post_tag'].length - 1
                                              ? Text(
                                              '#' + item['post_tag'][i] + ' ')
                                              : Text('#' + item['post_tag'][i]),
                                    ],
                                  ),
                                  // const SizedBox(
                                  //   width: 40,
                                  // ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      Text(item['post_like'].toString()),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
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
        bottomNavigationBar: Bottom(),
      );
    }

}
