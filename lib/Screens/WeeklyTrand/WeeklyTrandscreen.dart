import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../../Components/mainprovider.dart';
import '../Main_veiw/Bottom_main.dart';
import '../Main_veiw/Components/MP_WeeklyTrand.dart';
import '../Welcome/welcome_screen.dart';
import 'DateRecommend.dart';
import 'IngredientRecommend.dart';
import 'StarRecommend.dart';
import 'WeatherRecommend.dart';

class WeeklyTrandScreen extends StatefulWidget {
  const WeeklyTrandScreen({super.key});

  @override
  State<WeeklyTrandScreen> createState() => _WeeklyTrandScreenState();
}

class _WeeklyTrandScreenState extends State<WeeklyTrandScreen> {

  static const storage = FlutterSecureStorage();


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
        print(queryString);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('위클리 트렌드 모두보기'),
      ),
      body: ListView.builder(
        itemCount: imgList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // 클릭한 이미지에 따라 다른 페이지로 이동
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DateScreen()),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StarScreen()),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherScreen()),
                  );
                  break;
                case 3:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IngredientScreen()),
                  );
                  break;
                default:
                // 정의되지 않은 인덱스에 대한 처리
              }
            },
            child: Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage(imgList[index]),
                  fit: BoxFit.cover,
                ),
              ),
              height: 200, // 이미지 높이 조정
            ),
          );
        },
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}