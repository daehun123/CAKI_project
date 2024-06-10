import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import '../../Components/constants.dart';
import 'FilterScreenResult.dart';

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
  late GroupButtonController _reivewController;

  List<String> expertGroup = ['인증 ◯', '인증 ☓'];

  List<String> alcoholGroup = [
    '보드카',
    '럼',
    '브랜디',
    '위스키',
    '리큐르',
    '진',
    '데킬라',
    '소주',
    '맥주',
    '막걸리'
  ];

  List<String> tasteGroup = [
    '도수3',
    '당도3',
    '도수2',
    '당도2',
    '도수1',
    '당도1',
  ];

  List<String> otherGroup = [
    '탄산',
    '과일',
    '우유/크림',
  ];

  List<String> reviewGroup = [
    '달달해요',
    '써요',
    '셔요',
    '풍미가\n좋아요',
    '어려워요',
    '쉬워요',
    '싸요',
    '비싸요',
    '파티에\n좋아요',
    '혼자먹기\n좋아요',
    '둘이먹기\n좋아요',
    '트렌디해요',
    '추천해요',
    '예뻐요',
    '우디해요',
    '깔끔해요'
  ];

  List<String> choiceExpert = []; // 사용자의 선택을 저장하는 리스트
  List<String> choicealcohol = [];
  List<String> choicetaste = [];
  List<String> choiceother = [];
  List<String> choicereivew = [];
  int selectCount = 0;

  @override
  void initState() {
    super.initState();
    _alcoholController = GroupButtonController(selectedIndexes: []);
    _tasteController = GroupButtonController(selectedIndexes: []);
    _otherController = GroupButtonController(selectedIndexes: []);
    _expertController = GroupButtonController(selectedIndexes: []);
    _reivewController = GroupButtonController(selectedIndexes: []);
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
                        controller: _expertController,
                        // 술 종류 그룹에 대한 Controller
                        onSelected: (val, i, selected) {
                          // 선택 상태 변경 시 동작
                          setState(() {
                            if (selected) {
                              choiceExpert.add(val);
                              selectCount++;
                            } else {
                              choiceExpert.remove(val);
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
                        controller: _alcoholController,
                        // 술 종류 그룹에 대한 Controller
                        onSelected: (val, i, selected) {
                          // 선택 상태 변경 시 동작
                          setState(() {
                            if (selected) {
                              choicealcohol.add(val);
                              selectCount++;
                            } else {
                              choicealcohol.remove(val);
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
                        controller: _tasteController,
                        // 도수 & 당도 그룹에 대한 Controller
                        onSelected: (val, i, selected) {
                          // 선택 상태 변경 시 동작
                          setState(() {
                            if (selected) {
                              choicetaste.add(val);
                              selectCount++;
                            } else {
                              choicetaste.remove(val);
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
                        controller: _otherController,
                        // 기타음료 그룹에 대한 Controller
                        onSelected: (val, i, selected) {
                          // 선택 상태 변경 시 동작
                          setState(() {
                            if (selected) {
                              choiceother.add(val);
                              selectCount++;
                            } else {
                              choiceother.remove(val);
                              selectCount--;
                            }
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        '키워드 리뷰',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GroupButton(
                        buttons: reviewGroup,
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
                        controller: _reivewController,
                        // 도수 & 당도 그룹에 대한 Controller
                        onSelected: (val, i, selected) {
                          // 선택 상태 변경 시 동작
                          setState(() {
                            if (selected) {
                              choicereivew.add(val);
                              selectCount++;
                            } else {
                              choicereivew.remove(val);
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
              // 선택된 항목들을 하나의 리스트로 합침
              List<String> selectedKeywords = [];
              selectedKeywords.addAll(choiceExpert);
              selectedKeywords.addAll(choicealcohol);
              selectedKeywords.addAll(choicetaste);
              selectedKeywords.addAll(choiceother);
              selectedKeywords.addAll(choicereivew);

              // 선택된 항목들을 출력하여 확인
              debugPrint('Selected Keywords: $selectedKeywords');

              // ResultScreen으로 선택된 항목 리스트를 전달
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return FilterResultScreen(selectedKeywords: selectedKeywords);
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
