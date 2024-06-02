import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Welcome/welcome_screen.dart';

class SignupForm extends StatefulWidget {
  SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final signup_formkey = GlobalKey<FormState>();

  String? pwCheck, email, nickname, password;

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
              } else if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
                return '이메일 형식 확인.';
              }
              return null;
            },
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
                    if (signup_formkey.currentState!.validate()) {
                      signup_formkey.currentState!.save();
                      signUp(email!, nickname!, password!);
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
