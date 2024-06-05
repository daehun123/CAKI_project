import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../../Components/mainprovider.dart';
import '../Welcome/welcome_screen.dart';
import 'Bottom_main.dart';
import 'Components/MP_CatCheaper.dart';
import 'Components/MP_CatClassic.dart';
import 'Components/MP_CatExpert.dart';
import 'Components/MP_CatSimple.dart';
import 'Components/MP_WeeklyTrand.dart';
import 'Top_main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const storage = FlutterSecureStorage();
  String _wather = '';
  void initState(){
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    shareLocation();
  }
  Future<void> shareLocation() async {
    final provider = Provider.of<MainProvider>(context,listen: false);

    final main_Location = provider.location;
    double? nx = double.tryParse(main_Location.latitude.toString());
    double? ny = double.tryParse(main_Location.longitude.toString());
    var queryParams = {
      'nx': nx?.toStringAsFixed(0) ?? '0',
      'ny': ny?.toStringAsFixed(0) ?? '0'
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
        setState(() {
          //_wather = response.data['weather'];
        });
      } else if (response.statusCode == 401) {
        try {
          response = await dio.get(
            url,
            options: Options(
              headers: {'Authorization': 'Bearer $refresh_token'},
            ),
          );
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
    // 가져온 MediaQuery에서 화면의 가로 길이를 사용하여 각 위젯의 너비를 계산합니다.
    final screenWidth = MediaQuery.of(context).size.width;
    final WTWidth = (screenWidth - 20);
    final katWidth = WTWidth / 5; // 총 가로 길이에서 간격을 뺀 후, 5개의 위젯으로 나눕니다.

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: Apptop(context),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: WeeklyTrand(),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CatClassic(width: katWidth),
                  CatExpert(width: katWidth),
                  CatSimple(width: katWidth),
                  CatCheaper(width: katWidth),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}
