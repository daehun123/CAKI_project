import 'package:caki_project/Screens/WeeklyTrand/Recommend_list.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../Components/mainprovider.dart';
import 'MP_WeeklyAddBT.dart';

//이미지 리스트
final List<String> imgList = [
  'assets/Img/Date.jpeg',
  'assets/Img/Like.png',
  'assets/Img/Weather.png',
  'assets/Img/Ingredient.jpeg',
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          _getRecommendationText(imgList.indexOf(item)), //각각 해당하는 배너 이름 다름.
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();
class WeeklyTrand extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WeeklyTrandState();
  }
}
String _getRecommendationText(int index) {
  switch (index) {
    case 0:
      return '추천 요일별';
    case 1:
      return '추천 좋아요';
    case 2:
      return '추천 날씨';
    case 3:
      return '추천 취향';
    default:
      return '';
  }
}

class _WeeklyTrandState extends State<WeeklyTrand> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  double? send_nx;
  double? send_ny;


  void initState(){
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getLocation();
  }
  Future<void> getLocation() async {
    final provider = Provider.of<MainProvider>(context,listen: false);

    final main_Location = provider.location;
    double? nx = double.tryParse(main_Location.latitude.toString()) ?? 0;
    double? ny = double.tryParse(main_Location.longitude.toString()) ?? 0;
    send_nx = nx;
    send_ny = ny;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              switch (_current) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Trend_list(nx: send_nx!, ny: send_ny!, recommend: 'post_by_day',)),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Trend_list(nx: send_nx!, ny: send_ny!, recommend: 'post_by_like')),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Trend_list(nx: send_nx!, ny: send_ny!, recommend: 'post_by_weather')),
                  );
                  break;
                case 3:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Trend_list(nx: send_nx!, ny: send_ny!, recommend: 'post_by_ranking')),
                  );
                  break;
                default:
                // 정의되지 않은 인덱스에 대한 처리
              }
            },
            child: CarouselSlider(
              items: imageSliders.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      child: item,
                      // 수정된 부분: GestureDetector로 묶인 이미지 슬라이더
                    );
                  },
                );
              }).toList(),
              carouselController: _controller,
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () {
                  _controller.animateToPage(entry.key);
                },
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin:
                  EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
            SizedBox(width: 10),
            WeeklyAddBT(),
          ],
        ),
      ],
    );
  }
}
