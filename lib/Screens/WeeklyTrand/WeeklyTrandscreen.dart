import 'package:caki_project/Components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Components/mainprovider.dart';
import '../Main_veiw/Bottom_main.dart';
import '../Main_veiw/Components/MP_WeeklyTrand.dart';
import 'Recommend_list.dart';


class WeeklyTrandScreen extends StatefulWidget {
  const WeeklyTrandScreen({super.key});

  @override
  State<WeeklyTrandScreen> createState() => _WeeklyTrandScreenState();
}

class _WeeklyTrandScreenState extends State<WeeklyTrandScreen> {

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
    return Scaffold(
      appBar: AppBar(
        title: Text('위클리 트렌드 모두보기'),
        backgroundColor: kColor,
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
                    MaterialPageRoute(builder: (context) => Trend_list(nx: send_nx!, ny: send_ny!, recommend: 'post_by_day',)),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Trend_list(nx: send_nx!, ny: send_ny!, recommend: 'post_by_like',)),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Trend_list(nx: send_nx!, ny: send_ny!, recommend: 'post_by_weather',)),
                  );
                  break;
                case 3:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Trend_list(nx: send_nx!, ny: send_ny!, recommend: 'post_by_ranking',)),
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