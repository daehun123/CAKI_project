import 'package:caki_project/Screens/search/Search_Resultscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import '../../Components/constants.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late GroupButtonController _alcoholController;
  late GroupButtonController _tasteController;
  late GroupButtonController _otherController;
  late GroupButtonController _expertController;

  List<String> expertGroup = [
    '인증 ◯',
    '인증 ☓'
  ];

  List<String> alcoholGroup = [
    '보드카',
    '럼',
    '브랜디',
    '위스키',
    '리큐르',
    '진',
    '데킬라',
  ];

  List<String> tasteGroup = [
    '도수★★★',
    '당도★★★',
    '도수★★',
    '당도★★',
    '도수★',
    '당도★',
  ];

  List<String> otherGroup = [
    '탄산',
    '과일',
    '우유/크림',
  ];

  List<String> choiceList = []; // 사용자의 선택을 저장하는 리스트
  int selectCount = 0;

  @override
  void initState() {
    super.initState();
    _alcoholController = GroupButtonController(selectedIndexes: []);
    _tasteController = GroupButtonController(selectedIndexes: []);
    _otherController = GroupButtonController(selectedIndexes: []);
    _expertController = GroupButtonController(selectedIndexes: []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('#키워드 선택'),
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
                  Column(
                    children: [
                      SizedBox(height: 15),
                      Text(
                        '인증 유무',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GroupButton(
                        buttons: expertGroup,
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
                        controller: _expertController, // 술 종류 그룹에 대한 Controller
                        onSelected: (val, i, selected) {
                          // 선택 상태 변경 시 동작
                          setState(() {
                            if (selected) {
                              choiceList.add(val);
                              selectCount++;
                            } else {
                              choiceList.remove(val);
                              selectCount--;
                            }
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        '술 종류',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GroupButton(
                        buttons: alcoholGroup,
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
                        controller: _alcoholController, // 술 종류 그룹에 대한 Controller
                        onSelected: (val, i, selected) {
                          // 선택 상태 변경 시 동작
                          setState(() {
                            if (selected) {
                              choiceList.add(val);
                              selectCount++;
                            } else {
                              choiceList.remove(val);
                              selectCount--;
                            }
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        '도수 & 당도',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GroupButton(
                        buttons: tasteGroup,
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
                        controller: _tasteController, // 도수 & 당도 그룹에 대한 Controller
                        onSelected: (val, i, selected) {
                          // 선택 상태 변경 시 동작
                          setState(() {
                            if (selected) {
                              choiceList.add(val);
                              selectCount++;
                            } else {
                              choiceList.remove(val);
                              selectCount--;
                            }
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        '기타음료',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GroupButton(
                        buttons: otherGroup,
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
                        controller: _otherController, // 기타음료 그룹에 대한 Controller
                        onSelected: (val, i, selected) {
                          // 선택 상태 변경 시 동작
                          setState(() {
                            if (selected) {
                              choiceList.add(val);
                              selectCount++;
                            } else {
                              choiceList.remove(val);
                              selectCount--;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              maximumSize: const Size(200, 56),
              minimumSize: const Size(200, 56),
            ),
            onPressed: () {
              debugPrint('$choiceList');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ResultScreen();
                  },
                ),
              );
            },
            child: Text(
              '키워드 $selectCount개에 대한 검색'.toUpperCase(),
              style: TextStyle(fontSize: 15.0, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
