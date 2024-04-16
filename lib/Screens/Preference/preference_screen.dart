import 'package:caki_project/Components/background.dart';
import 'package:caki_project/Components/constants.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import '../Main_veiw/main_screen.dart';

class pre_choice extends StatelessWidget {
  List<String> choice_list = [];

  pre_choice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
