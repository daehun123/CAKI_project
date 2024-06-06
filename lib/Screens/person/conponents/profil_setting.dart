import 'package:caki_project/Components/constants.dart';
import 'package:caki_project/Screens/person/Personscreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../Welcome/welcome_screen.dart';

class ProfilSetting extends StatefulWidget {
  ProfilSetting({super.key});

  @override
  State<ProfilSetting> createState() => _ProfilSettingState();
}

class _ProfilSettingState extends State<ProfilSetting> {
  final setting_formkey = GlobalKey<FormState>();
  final pw_formkey = GlobalKey<FormState>();

  String? email, nickname, introduce, password, pwcheck;
  final picker = ImagePicker();
  XFile? image;

  String? check_code;
  bool flag = false;
  bool email_ck = false;
  static const storage = FlutterSecureStorage();

  String? input_code;

  Future<void> _naverLogout() async {
    try {
      await FlutterNaverLogin.logOutAndDeleteToken();
      print('object');
    } catch (e) {
      print(e);
    }
  }

  Future<void> _set_profil(String? email, String? nickname, String? password,
      String? introduce) async {
    String? path_nickname = await storage.read(key: 'nickname');
    var url = 'http://13.124.205.29/$path_nickname/';
    var dio = Dio();
    String? access_token = await storage.read(key: 'jwt_accessToken');
    String? refresh_token = await storage.read(key: 'jwt_refreshToken');

    try {
      var response = await dio.put(
        url,
        data: {
          'email': email,
          'nickname': nickname,
          'password': password,
          'introduce': introduce
        },
        options: Options(
          headers: {'Authorization': 'Bearer $access_token'},
        ),
      );
      if(response.statusCode == 200){
        storage.delete(key: 'nickname');
        storage.write(key: 'nickname', value: nickname);
        print(path_nickname);
        print(nickname);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('변경 완료'),
              content: Text('프로필 정보가 변경되었습니다.'),
              actions: <Widget>[
                TextButton(
                  child: Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                            PersonScreen()),
                            (route) => false);
                  },
                ),
              ],
            );
          },
        );
      }else if (response.statusCode == 401) {
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
          var reresponse = await dio.post(
            url,
            data: {'email': email},
            options: Options(
              headers: {'Authorization': 'Bearer $access_token'},
            ),
          );
          if (reresponse.statusCode == 200) {
            debugPrint('complete');
            check_code = reresponse.data['code'];
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
      print(e);
    }
  }

  Future<void> logout() async {
    storage.delete(key: 'jwt_accessToken');
    storage.delete(key: 'jwt_refreshToken');
    storage.delete(key: 'nickname');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PersonScreen()),
            );
          },
        ),
        title: Text('프로필 설정'),
        backgroundColor: kColor,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: setting_formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    cursorColor: const Color(0xFF8A9352),
                    onChanged: (value) {
                      email = value;
                    },
                    enabled: !email_ck,
                    validator: (value) {
                      if (!email_ck) {
                        if (flag) {
                          if (value == null || value.isEmpty) {
                            flag = false;
                            return '필수 입력 항목입니다.';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            flag = false;
                            return '이메일 형식 확인.';
                          }
                        } else
                          return null;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(Icons.email),
                      ),
                      suffix: OutlinedButton(
                        onPressed: () {
                          if (setting_formkey.currentState!.validate()) {
                            flag = true;
                            print(email);
                            _check_email(email!);
                          }
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    cursorColor: const Color(0xFF8A9352),
                    onSaved: (value) => nickname = value,
                    decoration: const InputDecoration(
                      labelText: 'NickName',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(Icons.person),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.lock,
                            color: kColor,
                          )),
                      const Text(
                        '**************',
                      ),
                      Spacer(
                        flex: 8,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('비밀번호 변경'),
                                content: Form(
                                  key: pw_formkey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        cursorColor: const Color(0xFF8A9352),
                                        onSaved: (value) {
                                          password = value;
                                        },
                                        decoration:
                                            InputDecoration(hintText: '새 비밀번호'),
                                        onChanged: (value) {
                                          pwcheck = value;
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '필수 입력 항목입니다.';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        cursorColor: const Color(0xFF8A9352),
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            hintText: '새 비밀번호 확인'),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '필수 입력 항목입니다.';
                                          } else if (pwcheck != value) {
                                            return '비밀번호 확인.';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  Row(
                                    children: [
                                      TextButton(
                                        child: Text('확인'),
                                        onPressed: () {
                                          if (pw_formkey.currentState!
                                              .validate()) {
                                            pw_formkey.currentState!.save();
                                            print('새 비밀번호: $password');
                                            print('새 비밀번호 확인: $pwcheck');
                                            Navigator.of(context).pop();
                                          }
                                        },
                                      ),
                                      TextButton(
                                        child: Text('취소'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('변경'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: kColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    cursorColor: const Color(0xFF8A9352),
                    maxLines: 3,
                    onSaved: (value) => introduce = value,
                    decoration: const InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(Icons.discord_outlined),
                      ),
                      labelText: '\n자기소개란',
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    Expanded(
                      flex: 8,
                      child: ElevatedButton(
                        onPressed: () {
                          if (setting_formkey.currentState!.validate()) {
                            setting_formkey.currentState!.save();
                            print(email);
                            print(password);
                            _set_profil(email, nickname, password, introduce);
                          }
                        },
                        child: Text('변경'.toUpperCase()),
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    Expanded(
                        flex: 8,
                        child: ElevatedButton(
                            onPressed: () {
                              logout();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Welcome_Screen()),
                                      (route) => false);
                            }, child: Text('로그아웃'))),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  child: Image.asset(
                    'assets/Img/btnG_로그아웃.png',
                    height: 56,
                  ),
                  onTap: () {
                    _naverLogout();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
