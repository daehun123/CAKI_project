import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Bottom_main.dart';
import 'Components/MP_KatCheaper.dart';
import 'Components/MP_KatClassic.dart';
import 'Components/MP_KatExpert.dart';
import 'Components/MP_KatSimple.dart';
import 'Components/MP_WeeklyTrand.dart';
import 'Top_main.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    // 가져온 MediaQuery에서 화면의 가로 길이를 사용하여 각 위젯의 너비를 계산합니다.
    final screenWidth = MediaQuery.of(context).size.width;
    final WTWidth = (screenWidth -20);
    final katWidth = WTWidth / 5; // 총 가로 길이에서 간격을 뺀 후, 5개의 위젯으로 나눕니다.

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: Apptop(context),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          WeeklyTrand(width: WTWidth),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KatClassic(width: katWidth),
                  KatExpert(width: katWidth),
                  KatSimple(width: katWidth),
                  KatCheaper(width: katWidth),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}
