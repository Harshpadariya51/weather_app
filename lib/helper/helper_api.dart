import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherApi {
  static Future<Map<String, dynamic>> fetchWeatherData(String text) async {
    final response = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=df08ef1012764017bdc90419240802&q=$text&aqi=no'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
