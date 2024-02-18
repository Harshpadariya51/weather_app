import 'package:flutter/material.dart';
import 'package:weather_app/helper/helper_api.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  weathermodel? _weather;

  weathermodel? get weather => _weather;

  Future<void> fetchWeatherData(String text) async {
    try {
      final decodedData = await WeatherApi.fetchWeatherData(text);
      _weather = weathermodel.fromJson(decodedData);
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to load weather data: $error');
    }
  }
}
