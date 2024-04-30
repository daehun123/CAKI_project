import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'MP_WeeklyAddBT.dart';
import 'MP_WeeklyBTblank.dart';

class WeeklyTrand extends StatelessWidget {
  final double width;
  const WeeklyTrand({Key? key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.center,
              child: Text(
                '주간 트렌드',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              right: 10, // 좌측 여백
              bottom: 10, // 하단 여백
              child: WeeklyAddBT(),
            ),
            Positioned(
              top: 200, // 버튼 위에 위치하도록 조정
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4, // 원하는 버튼 개수
                      (index) => WeeklyBTblank(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
