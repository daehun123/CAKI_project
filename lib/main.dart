import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'Components/mainprovider.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'Screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(ChangeNotifierProvider(create: (_) => MainProvider(),child : const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? latitude;
  String? longitude;
  StreamSubscription<Position>? positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    getGeoDataAndSend();
  }

  getGeoDataAndSend() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("permissions are denied");
      }
    }
    ListeningLocation();
  }

  ListeningLocation() {
    final provider = Provider.of<MainProvider>(context,listen: false);
    const locationSet = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );
    positionStreamSubscription =
        Geolocator.getPositionStream(locationSettings: locationSet)
            .listen((Position position) {
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
      provider.updateLocation(latitude, longitude);
      print(latitude);
      print(longitude);
    });
  }



  @override
  void dispose() {
    positionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(
          fontFamily: "Jalnan",
          primaryColor: const Color(0xFF8A9352),
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF8A9352),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            iconColor: Color(0xFF8A9352),
            prefixIconColor: Color(0xFF8A9352),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      home: FutureBuilder(
        future: Future.delayed(
            const Duration(seconds: 3), () => "Intro Completed."),
        builder: (context, snapshot) {
          return AnimatedSwitcher(
              duration: const Duration(milliseconds: 1000),
              child: _splashLoadingWidget(snapshot));
        },
      ),
    );
  }

  Widget _splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      return const Text("Error!!");
    } else if (snapshot.hasData) {
      return const Welcome_Screen();
    } else {
      return const Spalsh_Screen();
    }
  }
}
