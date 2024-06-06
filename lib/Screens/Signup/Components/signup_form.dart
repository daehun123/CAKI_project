import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Components/constants.dart';
import '../../Welcome/welcome_screen.dart';

class SignupForm extends StatefulWidget {
  SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final signup_formkey = GlobalKey<FormState>();

  String? pwCheck, email, nickname, password;

  static const storage = FlutterSecureStorage();

  String? check_code;
  bool flag = false;
  bool email_ck = false;
  String? input_code;

  Future<void> signUp(String email, String nickname, String password) async {
    final ByteData bytes = await rootBundle.load('assets/Img/userprofil.jpg');
    final Uint8List list = bytes.buffer.asUint8List();

    final response = await http.post(
      Uri.parse('http://13.124.205.29/signup/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'nickname': nickname,
        'password': password,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('회원가입 성공');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('회원가입 완료'),
            content: Text('회원가입이 성공적으로 완료되었습니다.'),
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
    } else {
      print('회원가입 실패');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('회원가입 실패'),
            content: Text('아이디,비밀번호를 확인해주세요.'),
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

  Future<void> _check_email(String email) async {
    var url = 'http://13.124.205.29/signup/emailverifi/';
    var dio = Dio();
    String? access_token = await storage.read(key: 'jwt_accessToken');
    String? refresh_token = await storage.read(key: 'jwt_refreshToken');

    try {
      var response = await dio.post(
        url,
        data: {'email': email},
        options: Options(
          headers: {'Authorization': 'Bearer $access_token'},
        ),
      );
      if (response.statusCode == 200) {
        debugPrint('complete');
        check_code = response.data['code'];
        debugPrint(check_code);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('이메일 인증 코드를 입력해주세요.'),
              content: TextFormField(
                cursorColor: const Color(0xFF8A9352),
                onChanged: (value) {
                  input_code = value;
                },
                decoration: InputDecoration(hintText: '인증코드'),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('확인'),
                  onPressed: () {
                    print(check_code);
                    if (input_code.toString() == check_code.toString()) {
                      email_ck = true;
                      Navigator.pop(context);
                      setState(() {});
                    } else {
                      print(check_code);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('인증 코드 불일치'),
                              content: Text('입력한 인증 코드가 올바르지 않습니다.'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('확인'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    }
                  },
                ),
              ],
            );
          },
        );
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
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signup_formkey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: const Color(0xFF8A9352),
            enabled: !email_ck,
            onChanged: (value) => email = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '필수 입력 항목입니다.';
              } else if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
                return '이메일 형식 확인.';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'E-mail',
              prefixIcon: Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.email),
              ),
              suffix: OutlinedButton(
                onPressed: () {
                  print(email);
                  _check_email(email!);
                },
                child: Text('인증'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: kColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              cursorColor: const Color(0xFF8A9352),
              onSaved: (value) => nickname = value,
              decoration: const InputDecoration(
                hintText: 'NickName',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.person),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              obscureText: true,
              cursorColor: const Color(0xFF8A9352),
              onSaved: (value) => password = value,
              decoration: const InputDecoration(
                hintText: 'Pw',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.lock),
                ),
              ),
              onChanged: (value) {
                pwCheck = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '필수 입력 항목입니다.';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: const Color(0xFF8A9352),
              decoration: const InputDecoration(
                hintText: 'Pw_Check',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.lock),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '필수 입력 항목입니다.';
                } else if (pwCheck != value) {
                  return '비밀번호 확인.';
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
                  onPressed: () {
                    if(email_ck) {
                      if (signup_formkey.currentState!.validate()) {
                        signup_formkey.currentState!.save();
                        signUp(email!, nickname!, password!);
                      }
                    }else{
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('이메일 인증'),
                            content: Text('이메일을 인증해주세요.'),
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
                  },
                  child: Text('Sign Up'.toUpperCase()),
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
