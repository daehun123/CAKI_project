import 'package:caki_project/Screens/Preference/preference_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginForm extends StatefulWidget {
  LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final login_formkey = GlobalKey<FormState>();

  String? _email, _password;

  Future<void> login(String email, String password) async {
    var url = Uri.parse('');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data['message']);
    } else {
      print('로그인 실패');
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
            onSaved: (value) => _email = value,
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
              onSaved: (value) => _password = value,
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
                  onPressed: () {
                    if (login_formkey.currentState!.validate()) {
                      login_formkey.currentState!.save();
                      //login(_email!, _password!);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => pre_choice()),
                          (route) => false);
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
