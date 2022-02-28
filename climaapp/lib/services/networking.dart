import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:climaapp/services/location.dart';

import '../utilities/apiKeys.dart';

class NetworkHelper {
  NetworkHelper(this.location);

  Location location;

  Future getData() async {
    http.Response weatherData = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?'
        'lat=${location.latitude}&lon=${location.longitude}&appid=$kAPIKey'));
    if (weatherData.statusCode == 200) {
      return jsonDecode(weatherData.body);
    } else {
      return null;
    }
  }
}
