import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:url_launcher/url_launcher.dart'; // url_launcher 패키지 import
import 'package:dio/dio.dart';

class PositionShop extends StatelessWidget {
  const PositionShop({Key? key}) : super(key: key);

  // 지도 초기화하기
  Future<void> _initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      await NaverMapSdk.instance.initialize(
        clientId: 'li44ix0d94', // 클라이언트 ID 설정
        onAuthFailed: (e) => log("네이버맵 인증오류 : $e", name: "onAuthFailed"),
      );
    } catch (e) {
      log("네이버맵 초기화 오류 : $e", name: "initializeNaverMap");
    }
  }

  // 백엔드에서 데이터 가져오기
  Future<List<Map<String, dynamic>>> _fetchData() async {
    final dio = Dio();
    const url = 'http://13.124.205.29/maps/';

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic> && responseData.containsKey('shops')) {
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
    // 지도 초기화
    _initialize();

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
                  initialCameraPosition: NCameraPosition(
                    target: NLatLng(36.8188, 127.1571), // 천안시의 위도, 경도
                    zoom: 12,
                  ),
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
                    // 마커 이름 보여주기
                    final onMarkerInfoWindow = NInfoWindow.onMarker(id: marker.info.id, text: shopName);
                    marker.openInfoWindow(onMarkerInfoWindow);

                    marker.setOnTapListener((NMarker marker) async {
                      // 마커 터치 이벤트 처리
                      print("마커가 터치되었습니다. id: ${marker.info.id}");

                      // URL 열기
                      String url = shop['url'];
                      if (url.isNotEmpty) {
                        try {
                          await launch(url);
                        } catch (e) {
                          print('웹사이트를 열던 중 오류가 발생했습니다: $e');
                        }
                      }
                    });
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
