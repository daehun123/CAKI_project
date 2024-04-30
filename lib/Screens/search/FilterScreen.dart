import 'package:caki_project/Screens/search/Search_Resultscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import '../../Components/constants.dart';
import '../Preference/preference_screen.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> choiceList = []; // 사용자의 선택을 저장하는 리스트
  int selectCount = 0;
  late GroupButtonController _controller; // GroupButtonController 선언

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ScrollInjector(
                  // 그룹 버튼을 가로로 스크롤 가능하게 만들기 위한 위젯
                  groupingType: GroupingType.wrap,
                  child: GroupButton(
                    buttons: const [
                      // 버튼 그룹의 옵션들
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
                      // 선택된 버튼의 색상
                      unselectedColor: Colors.grey,
                      // 선택되지 않은 버튼의 색상
                      unselectedTextStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      spacing: 5,
                      // 버튼 사이의 간격
                      buttonWidth: MediaQuery.of(context).size.width / 2.4,
                    ),
                    isRadio: false,
                    controller: _controller, // 생성한 controller 할당
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
                    '키워드 $selectCount개에 대한 검색'.toUpperCase(), // 검색 버튼 텍스트
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
