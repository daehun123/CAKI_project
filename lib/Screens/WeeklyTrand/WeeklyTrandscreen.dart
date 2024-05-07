import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Main_veiw/Bottom_main.dart';
import '../Main_veiw/Components/MP_WeeklyTrand.dart';
import 'DateRecommend.dart';
import 'IngredientRecommend.dart';
import 'StarRecommend.dart';
import 'WeatherRecommend.dart';

class WeeklyTrandScreen extends StatelessWidget {
  const WeeklyTrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('위클리 트렌드 모두보기'),
      ),
      body: ListView.builder(
        itemCount: imgList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // 클릭한 이미지에 따라 다른 페이지로 이동
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DateScreen()),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StarScreen()),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherScreen()),
                  );
                  break;
                case 3:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IngredientScreen()),
                  );
                  break;
                default:
                // 정의되지 않은 인덱스에 대한 처리
              }
            },
            child: Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage(imgList[index]),
                  fit: BoxFit.cover,
                ),
              ),
              height: 200, // 이미지 높이 조정
            ),
          );
        },
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}