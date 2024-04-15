import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Main_veiw/Bottom_main.dart';

class WeeklyTrandScreen extends StatelessWidget {
  const WeeklyTrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('위클리 트렌드 모두보기'),
        ),
        bottomNavigationBar: Bottom()
    );
  }
}
