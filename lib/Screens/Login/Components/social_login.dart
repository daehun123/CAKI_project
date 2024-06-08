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
  String? email, password, nickname;
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

  Future<void> send_token(String? email, String? nickname) async {
    var url = 'http://13.124.205.29/authuser/naver/login/';
    var dio = Dio();

    print('email : $email , nickname : $nickname');
    try {
      var response = await dio.post(
        url,
        data: {'email': email, 'nickname': nickname},
        options: Options(
          headers: {},
        ),
      );
      print('sdsdsdsd : ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        print(response.data);
        _accesstoken = response.data['access_token'];
        _refreshtoken = response.data['refresh_token'];
        await storage.write(key: 'jwt_accessToken', value: _accesstoken);
        await storage.write(key: 'jwt_refreshToken', value: _refreshtoken);
        await storage.write(key: 'nickname', value: nickname);
        print(_accesstoken);
        _ckFirstLogin();
      }
    } catch (e) {
      print(': ' + e.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('로그인 실패'),
            content: Text('이미 가입된 아이디입니다.'),
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
    }
  }

  Future<void> _naverLogin() async {
    try {
      await FlutterNaverLogin.logIn().then((value) async {
        nickname = value.account.nickname;
        email = value.account.email;
        print('value : $email , $nickname ');
        send_token(email, nickname);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _naverLogout() async {
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
          child: Image.asset(
            'assets/Img/naverlogin_btn.png',
            height: 56,
          ),
          onTap: () {
            _naverLogin();
          },
        ),
      ],
    );
  }
}
