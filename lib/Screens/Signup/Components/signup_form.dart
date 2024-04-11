import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import '../../Welcome/welcome_screen.dart';

class SignupForm extends StatelessWidget {
  final signup_formkey = GlobalKey<FormState>();
  String? pwCheck;

  SignupForm({super.key});

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
            onSaved: (email) {},
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
              } else if (RegExp(
                  r'^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')
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
              obscureText: true,
              cursorColor: const Color(0xFF8A9352),
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
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                              const Welcome_Screen()),
                              (route) => false);
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
