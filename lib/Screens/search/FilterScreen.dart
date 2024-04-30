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
  late GroupButtonController _controller; // GroupButtonController 선언
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
    '도수★★',
    '도수★',
    '당도★★★',
    '당도★★',
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
    _controller = GroupButtonController(selectedIndexes: []);
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
                        '술 그룹', // 술 그룹 텍스트 추가
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      // 술 그룹 버튼
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
                        controller: _controller,
                        onSelected: (val, i, selected) {
                          setState(() {
                            if (selected) {
                              choiceList.add(val); // 선택된 버튼을 리스트에 추가
                              selectCount++; // 선택된 취향 개수 증가
                            } else {
                              choiceList.remove(val);
                              // 선택 취소된 버튼을 리스트에서 제거
                              debugPrint('$choiceList');
                              // 선택된 취향 리스트를 디버그 로그로 출력
                              selectCount--; // 선택된 취향 개수 감소
                            }
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        '당도 그룹', // 당도 그룹 텍스트 추가
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      // 당도 그룹 버튼
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
                        controller: _controller,
                        onSelected: (val, i, selected) {
                          setState(() {
                            if (selected) {
                              choiceList.add(val); // 선택된 버튼을 리스트에 추가
                              selectCount++; // 선택된 취향 개수 증가
                            } else {
                              choiceList.remove(val);
                              // 선택 취소된 버튼을 리스트에서 제거
                              debugPrint('$choiceList');
                              // 선택된 취향 리스트를 디버그 로그로 출력
                              selectCount--; // 선택된 취향 개수 감소
                            }
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        '기타음료 그룹', // 기타음료 그룹 텍스트 추가
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      // 기타음료 그룹 버튼
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
                        controller: _controller,
                        onSelected: (val, i, selected) {
                          setState(() {
                            if (selected) {
                              choiceList.add(val); // 선택된 버튼을 리스트에 추가
                              selectCount++; // 선택된 취향 개수 증가
                            } else {
                              choiceList.remove(val);
                              // 선택 취소된 버튼을 리스트에서 제거
                              debugPrint('$choiceList');
                              // 선택된 취향 리스트를 디버그 로그로 출력
                              selectCount--; // 선택된 취향 개수 감소
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
              debugPrint('$choiceList'); // 선택된 취향 리스트를 디버그 로그로 출력
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ResultScreen(); // 검색결과 페이지로 이동
                  },
                ),
              );
            },
            child: Text(
              '키워드 $selectCount개에 대한 검색'.toUpperCase(),
              style: TextStyle(fontSize: 15.0, color: Colors.black,), // 흰색 텍스트// 검색 버튼 텍스트
            ),
          ),
        ),
      ),
    );
  }
}
