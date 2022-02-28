import 'package:climaapp/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:climaapp/utilities/constants.dart';
import 'package:climaapp/services/location.dart';

import '../services/networking.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({required this.weatherData});
  var weatherData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late double temp;
  late String city;
  late String weatherIcon;
  late String weatherMessage;
  @override
  void initState() {
    updateUI();
    super.initState();
  }

  void updateUI() {
    if (widget.weatherData != null) {
      int condition = widget.weatherData['weather'][0]['id'];
      weatherIcon = WeatherModel().getWeatherIcon(condition);
      temp = widget.weatherData['main']['temp'] - 273.15;
      city = widget.weatherData['name'];
      weatherMessage = WeatherModel().getMessage(temp.toInt());
    } else {
      weatherIcon = '❗';
      temp = 0;
      city = '';
      weatherMessage = 'An Error Has Occurred';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      Location _location = Location();
                      await _location.getCurrentLocation();
                      widget.weatherData =
                          await NetworkHelper(_location).getData();
                      updateUI();
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temp.toInt()}°C',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage $city!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
