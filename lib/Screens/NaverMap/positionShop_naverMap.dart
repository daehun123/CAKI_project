import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../../Components/mainprovider.dart';

class PositionShop extends StatelessWidget {
  const PositionShop({Key? key}) : super(key: key);


  // 백엔드에서 데이터 가져오기
  Future<List<Map<String, dynamic>>> _fetchData() async {
    final dio = Dio();
    const url = 'http://13.124.205.29/maps/';

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('shops')) {
          final List<dynamic> shops = responseData['shops'];
          return List<Map<String, dynamic>>.from(shops);
        } else {
          log('백엔드 오류: 데이터 형식이 잘못되었습니다.', name: 'fetchData');
          return [];
        }
      } else {
        log('백엔드 오류: ${response.statusCode}', name: 'fetchData');
        return [];
      }
    } catch (e) {
      log('백엔드 통신 오류: $e', name: 'fetchData');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final Completer<NaverMapController> mapControllerCompleter = Completer();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('근처 매장'),
        ),
        body: FutureBuilder(
          future: _fetchData(),
          builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('데이터를 가져오는 중 오류가 발생했습니다.'));
            } else {
              final shops = snapshot.data!;
              return NaverMap(
                options: const NaverMapViewOptions(
                  indoorEnable: true,
                  locationButtonEnable: false,
                  consumeSymbolTapEvents: false,
                ),
                onMapReady: (controller) async {
                  mapControllerCompleter.complete(controller);
                  log("onMapReady", name: "onMapReady");

                  // 마커 생성
                  for (var shop in shops) {
                    final String shopName = shop['shopname'];
                    final double latitude = shop['latitude'];
                    final double longitude = shop['longitude'];
                    final NLatLng target = NLatLng(latitude, longitude);

                    final marker = NMarker(
                      id: shopName,
                      position: target,
                    );
                    controller.addOverlay(marker);

                    final onMarkerInfoWindow = NInfoWindow.onMarker(id: marker.info.id, text: shopName);
                    marker.openInfoWindow(onMarkerInfoWindow);
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
