import 'package:flutter/material.dart';

class Weather {
  final String cityName;
  final double temperature;
  final String theIcon;
  final String description ;
  final int humidity;
  final double windSpeed;

  Weather({required this.cityName, required this.temperature, required this.theIcon, required this.description, required this.humidity, required this.windSpeed});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      theIcon: json['weather'][0]['icon'],
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }
}
