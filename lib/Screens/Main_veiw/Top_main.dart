import 'package:caki_project/Components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Components/Mainpagesearchbox.dart';
String getWeatherInEnglish(String weather) {
  switch (weather) {
    case '맑음':
      return 'sunny';
    case '흐림':
      return 'cloudy';
    case '구름많음':
      return 'cloudy';
    case '비':
      return 'rainy';
    case '눈':
      return 'snowy';
    default:
      return 'sunny';
  }
}
@override
PreferredSizeWidget Apptop(BuildContext context, String weather) {
  String weatherInEnglish = getWeatherInEnglish(weather);
  IconData weatherIcon;
  switch (weatherInEnglish) {
    case 'sunny':
      weatherIcon = Icons.wb_sunny;
      break;
    case 'cloudy':
      weatherIcon = Icons.cloud;
      break;
    case 'rainy':
      weatherIcon = Icons.water_drop;
      break;
    case 'snowy':
      weatherIcon = Icons.ac_unit;
      break;
    default:
      weatherIcon = Icons.wb_sunny;
  }

  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: kColor,
    title: Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          SizedBox(width: 8.0),
          Text(
            'CAKI',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(weatherIcon, color: Colors.white),
        ],
      ),
    ),
    bottom: searchBox(context),
  );
}


