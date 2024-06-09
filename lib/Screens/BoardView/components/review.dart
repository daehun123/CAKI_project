import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:group_button/group_button.dart';

import '../../../Components/constants.dart';
import '../../Preference/preference_screen.dart';

class keyword_reveiw extends StatefulWidget {
  const keyword_reveiw({super.key, required this.boardid});
  final int boardid;

  @override
  State<keyword_reveiw> createState() => _keyword_reveiwState();
}

class _keyword_reveiwState extends State<keyword_reveiw> {
  List<String> choice_list = [];
  static const storage = FlutterSecureStorage();

  Future<void> _send_review(List<String> list) async{
    var url =
        'http://13.124.205.29/review/' + widget.boardid.toString() + '/';
    var dio = Dio();
    String? access_token = await storage.read(key: 'jwt_accessToken');
    Map<String, dynamic> data = {'review' : list};

    try {
      var response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {'Authorization': 'Bearer $access_token'},
        ),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('success');
      }
    }catch(e){
      print('error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ScrollInjector(
              groupingType: GroupingType.wrap,
              child: GroupButton(
                  buttons: const [
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
                  ],
                  options: GroupButtonOptions(
                    selectedShadow: const [],
                    unselectedShadow: const [],
                    selectedTextStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    selectedColor: kColor,
                    unselectedColor: Colors.grey,
                    unselectedTextStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    spacing: 5,
                    buttonWidth: MediaQuery.of(context).size.width / 5,
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
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                maximumSize: const Size(150, 40),
                minimumSize: const Size(150, 40),
              ),
              onPressed: () {
                _send_review(choice_list);
              },
              child: Text(
                '키워드리뷰\n     작성!'.toUpperCase(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
