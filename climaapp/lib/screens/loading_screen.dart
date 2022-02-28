import 'dart:convert';

import 'package:climaapp/screens/location_screen.dart';
import 'package:climaapp/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:climaapp/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import 'package:geolocator/geolocator.dart';

import '../utilities/apiKeys.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Location _location = Location();

  void getLoc() async {
    await _location.getCurrentLocation();
    var decodeData = await NetworkHelper(_location).getData();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(weatherData: decodeData)));
  }

  void getWeatherData() async {}

  void initState() {
    getLoc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitRipple(
        color: Colors.greenAccent,
        size: MediaQuery.of(context).size.width / 3 * 2,
      )),
    );
  }
}
