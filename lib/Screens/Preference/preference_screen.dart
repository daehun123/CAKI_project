import 'package:caki_project/Components/background.dart';
import 'package:caki_project/Components/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:group_button/group_button.dart';

import '../Main_veiw/main_screen.dart';
import '../Welcome/welcome_screen.dart';

class pre_choice extends StatefulWidget {

  pre_choice({super.key});

  @override
  State<pre_choice> createState() => _pre_choiceState();
}

class _pre_choiceState extends State<pre_choice> {
  List<String> choice_list = [];
  static const storage = FlutterSecureStorage();

  Future<void> _send_pre(List<String> list) async {
    var url = 'http://13.124.205.29/preference/';
    var dio = Dio();
    String? access_token = await storage.read(key: 'jwt_accessToken');
    String? refresh_token = await storage.read(key: 'jwt_refreshToken');
    Map<String, dynamic> data = {'preference' : list};
    try {
      var response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {'Authorization': 'Bearer $access_token'},
        ),
      );
      if (response.statusCode == 200) {
        print('success');
      } else if (response.statusCode == 401) {
        try {
          response = await dio.get(
            url,
            data: data,
            options: Options(
              headers: {'Authorization': 'Bearer $refresh_token'},
            ),
          );
          if (response.statusCode == 200) {
            print('success');
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
      print('error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () { return Future(() => false); },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '취향을 선택해주세요!',
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ScrollInjector(
                      groupingType: GroupingType.wrap,
                      child: GroupButton(
                          buttons: const [
                            '도수★★★',
                            '당도★★★',
                            '도수★★',
                            '당도★★',
                            '도수★',
                            '당도★',
                            '과일',
                            '우유/크림',
                            '탄산',
                            '보드카',
                            '럼',
                            '브랜디',
                            '위스키',
                            '리큐르',
                            '진',
                            '데킬라'
                          ],
                          options: GroupButtonOptions(
                            selectedShadow: const [],
                            unselectedShadow: const [],
                            selectedTextStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            selectedColor: kColor,
                            unselectedColor: Colors.grey,
                            unselectedTextStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            spacing: 5,
                            buttonWidth: MediaQuery.of(context).size.width / 2.4,
                          ),
                          isRadio: false,
                          controller: GroupButtonController(
                            selectedIndexes: const [],
                          ),
                          onSelected: (val, i, selected) => {
                                debugPrint('Button: $val index: $i $selected'),
                                if (selected)
                                  choice_list.add(val)
                                else
                                  choice_list.remove(val),
                                debugPrint('$choice_list'),
                              }),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        maximumSize: const Size(200, 56),
                        minimumSize: const Size(200, 56),
                      ),
                      onPressed: () {
                        debugPrint('$choice_list');
                        _send_pre(choice_list);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const MyHomePage();
                            },
                          ),
                        );
                      },
                      child: Text(
                        '선택 완료'.toUpperCase(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ScrollInjector extends StatelessWidget {
  const ScrollInjector({
    Key? key,
    required this.child,
    required this.groupingType,
  }) : super(key: key);

  final Widget child;
  final GroupingType groupingType;

  @override
  Widget build(BuildContext context) {
    if (groupingType == GroupingType.row) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: child,
      );
    }
    return child;
  }
}
