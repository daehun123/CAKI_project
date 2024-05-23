import 'package:caki_project/Screens/Main_veiw/main_screen.dart';
import 'package:caki_project/Screens/Preference/preference_screen.dart';
import 'package:caki_project/Screens/Welcome/welcome_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final login_formkey = GlobalKey<FormState>();

  String? email, password;
  static const storage = FlutterSecureStorage();

  Future<void> login(String email, String password) async {
    var url = 'http://13.124.205.29/authuser/';
    var dio = Dio();
    var data = {
      'email': email,
      'password': password,
    };
    try {
      var response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        String _accesstoken = response.data['access_token'];
        String _refreshtoken = response.data['refresh_token'];
        print('token : $_accesstoken');
        print('token : $_refreshtoken');
        await storage.write(key: 'jwt_accessToken', value: _accesstoken);
        await storage.write(key: 'jwt_refreshToken', value: _refreshtoken);
        _ckFirstLogin();
      }
    } catch (e) {
      print("로그인 에러");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('로그인 실패'),
            content: Text('아이디,비밀번호를 확인해주세요.'),
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: login_formkey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: const Color(0xFF8A9352),
            onSaved: (value) => email = value,
            decoration: const InputDecoration(
              hintText: 'E-mail',
              prefixIcon: Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.email),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '필수 입력 항목입니다.';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: const Color(0xFF8A9352),
              onSaved: (value) => password = value,
              decoration: const InputDecoration(
                hintText: 'PassWord',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.lock),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '필수 입력 항목입니다.';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 8,
                child: ElevatedButton(
                  onPressed: () async {
                    if (login_formkey.currentState!.validate()) {
                      login_formkey.currentState!.save();
                      login(email!, password!);
                    }
                  },
                  child: Text('Login'.toUpperCase()),
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
