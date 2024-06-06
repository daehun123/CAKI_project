import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Main_veiw/main_screen.dart';
import '../../Preference/preference_screen.dart';

class Naver_Login_btn extends StatefulWidget {
  const Naver_Login_btn({super.key});

  @override
  State<Naver_Login_btn> createState() => _Naver_Login_btnState();
}

class _Naver_Login_btnState extends State<Naver_Login_btn> {
  var _accesstoken;
  var _refreshtoken;
  String? email;
  static const storage = FlutterSecureStorage();


  _ckFirstLogin() async {
    final ckPrefs = await SharedPreferences.getInstance();
    bool isFirstLogin = ckPrefs.getBool('first$email') ?? true;
    if (isFirstLogin) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => pre_choice()),
              (route) => false);
      await ckPrefs.setBool('first$email', false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => MyHomePage()),
              (route) => false);
    }
  }
  Future<void> send_token() async {
    var url = 'http://13.124.205.29/authuser/naver/login/';
    var dio = Dio();

   // try {
      dio.get(
        url,
        options: Options(
          headers: {},
        ),
      );
      // print('sdsdsdsd : ' + response.statusCode.toString());
      // if(response.statusCode == 200) {
      //   _accesstoken = response.headers['access_token'];
      //   _refreshtoken = response.headers['refresh_token'];
      //   await storage.write(key: 'jwt_accessToken', value: _accesstoken);
      //   await storage.write(key: 'jwt_refreshToken', value: _refreshtoken);
      //   print(_accesstoken);
      //   _ckFirstLogin();
    //}
    // else if(response.statusCode == 401){
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('로그인 실패'),
    //         content: Text('이미 가입된 아이디입니다.'),
    //         actions: <Widget>[
    //           TextButton(
    //             child: Text('확인'),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }
    // }catch(e){
    //   print(': ' + e.toString());
    // }

  }
  Future<void> _naverLogin() async {
    try {
      await FlutterNaverLogin.logIn().then((value) async{
        NaverAccessToken res = await FlutterNaverLogin.currentAccessToken;
        _accesstoken = res.accessToken;
        _refreshtoken = res.refreshToken;
        email = value.account.email;
        await storage.write(key: 'jwt_accessToken', value: _accesstoken);
        await storage.write(key: 'jwt_refreshToken', value: _refreshtoken);
        print(_accesstoken);
        print(_refreshtoken);
        print(email);
        _ckFirstLogin();
      });

    } catch (e) {
      print(e);
    }
  }
  Future<void> _naverLogout() async{
    try {
      await FlutterNaverLogin.logOutAndDeleteToken();
      print('object');
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: Image.asset('assets/Img/naverlogin_btn.png',height: 56,),
          onTap: (){
            send_token();
          },
        ),
        InkWell(
          child: Image.asset('assets/Img/btnG_로그아웃.png',height: 56,),
          onTap: (){
            _naverLogout();
          },
        ),
      ],
    );
  }
}
