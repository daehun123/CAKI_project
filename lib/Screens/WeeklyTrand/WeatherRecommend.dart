import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Main_veiw/Bottom_main.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('날씨별 추천'),
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}
