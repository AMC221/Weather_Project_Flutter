import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../Models/weather.dart';



class WeatherService {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  static const String _apiKey = 'daf7f8250d4f11f19738163cb04d1337';

  static Future<Weather> fetchWeather(String cityName) async {
    final response = await Dio().get(_baseUrl, queryParameters: {
      'q': cityName,
      'appid': _apiKey,
      'units': 'metric',
    });

    if (response.statusCode == 200) {
      return Weather.fromJson(response.data);
    } else {
      Get.snackbar(
        'Error',
        'Error while fetching weather data: ${response.statusCode}',
        snackPosition: SnackPosition.BOTTOM,
      );
      throw Exception('Error while fetching weather data: ${response.statusCode}');
    }


  }
}