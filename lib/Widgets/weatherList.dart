import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import '../Models/weather.dart';

class WeatherListTile extends StatelessWidget {
  final Weather weather;


  const WeatherListTile({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDay = DateTime.now().hour >= 6 && DateTime.now().hour < 20;
    bool isHot = weather.temperature > 25;

    Color backgroundColor = isDay
        ? isHot
        ? Colors.orange
        : Colors.lightBlue
        : isHot
        ? Colors.cyan
        : Colors.blueAccent;

    Color textColor = isDay ? Colors.white : Colors.white;
// les icons
    IconData weatherIcon = isDay
        ? WeatherIcons.day_sunny
        : WeatherIcons.night_clear;

    if (weather.description.contains('nuageux')) {
      weatherIcon = isDay
          ? WeatherIcons.day_cloudy
          : WeatherIcons.night_alt_cloudy;
    } else if (weather.description.contains('partiellement nuageux')) {
      weatherIcon = isDay
          ? WeatherIcons.day_cloudy_high
          : WeatherIcons.night_alt_partly_cloudy;
    } else if (weather.description.contains('pluvieux')) {
      weatherIcon = isDay
          ? WeatherIcons.day_rain
          : WeatherIcons.night_alt_rain;
    } else if (weather.description.contains('orageux')) {
      weatherIcon = isDay
          ? WeatherIcons.day_thunderstorm
          : WeatherIcons.night_alt_thunderstorm;
    } else if (weather.description.contains('neige')) {
      weatherIcon = isDay
          ? WeatherIcons.day_snow
          : WeatherIcons.night_alt_snow;
    } else if (weather.description.contains('brouillard')) {
      weatherIcon = isDay
          ? WeatherIcons.day_fog
          : WeatherIcons.night_fog;
    }

    // les images
    String getImagePath = isDay
        ? "assets/images/01d.png"
        : "assets/images/01n.png";

    if (weather.description.contains('clear sky') ||
        weather.description.contains('sky is clear') ||
        weather.description.contains('clear')) {
      getImagePath = isDay
          ? "assets/images/01d.png"
          : "assets/images/01n.png";
    } else if (weather.description.contains('few clouds') ||
        weather.description.contains('scattered clouds') ||
        weather.description.contains('broken clouds') ||
        weather.description.contains('overcast clouds') ||
        weather.description.contains('cloudy')) {
      getImagePath = isDay
          ? "assets/images/02d.png"
          : "assets/images/02n.png";
    } else if (weather.description.contains('rainy') ||
        weather.description.contains('drizzle') ||
        weather.description.contains('shower rain') ||
        weather.description.contains('light rain') ||
        weather.description.contains('moderate rain') ||
        weather.description.contains('heavy intensity rain') ||
        weather.description.contains('very heavy rain') ||
        weather.description.contains('extreme rain') ||
        weather.description.contains('freezing rain') ||
        weather.description.contains('light intensity shower rain') ||
        weather.description.contains('heavy intensity shower rain') ||
        weather.description.contains('ragged shower rain')) {
      getImagePath = isDay
          ? "assets/images/09d.png"
          : "assets/images/09n.png";
    } else if (weather.description.contains('stormy') ||
        weather.description.contains('thunderstorm') ||
        weather.description.contains('thunderstorm with light rain') ||
        weather.description.contains('thunderstorm with rain') ||
        weather.description.contains('thunderstorm with heavy rain') ||
        weather.description.contains('light thunderstorm') ||
        weather.description.contains('heavy thunderstorm') ||
        weather.description.contains('ragged thunderstorm') ||
        weather.description.contains('thunderstorm with light drizzle') ||
        weather.description.contains('thunderstorm with drizzle') ||
        weather.description.contains('thunderstorm with heavy drizzle') ){
      getImagePath = isDay
          ? "assets/images/11d.png"
          : "assets/images/11n.png";
    } else if (weather.description.contains('snowy') ||
        weather.description.contains('light snow') ||
        weather.description.contains('Snow') ||
        weather.description.contains('Heavy snow') ||
        weather.description.contains('Sleet') ||
        weather.description.contains('Light shower sleet') ||
        weather.description.contains('Shower sleet') ||
        weather.description.contains('Light rain and snow') ||
        weather.description.contains('Rain and snow') ||
        weather.description.contains('Light shower snow') ||
        weather.description.contains('Shower snow') ||
        weather.description.contains('Heavy shower snow')) {
      getImagePath = isDay
          ? "assets/images/13d.png"
          : "assets/images/13n.png";
    } else if (weather.description.contains('mist') ||
        weather.description.contains('smoke') ||
        weather.description.contains('haze') ||
        weather.description.contains('sand, dust whirls') ||
        weather.description.contains('fog') ||
        weather.description.contains('sand') ||
        weather.description.contains('dust') ||
        weather.description.contains('volcanic ash') ||
        weather.description.contains('squalls') ||
        weather.description.contains('tornado')) {
      getImagePath = isDay
          ? "assets/images/04d.png"
          : "assets/images/04n.png";
    }


    // Dégradé de couleur en fonction de l'heure et de la température
    List<Color> gradientColors = [
      backgroundColor,
      isHot ? Colors.red : Colors.deepPurple,
    ];
    Gradient backgroundGradient = LinearGradient(
      colors: gradientColors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    print(getImagePath);
    print(weather.description);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 10,

      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: backgroundGradient, // Utilisation du dégradé de couleur comme arrière-plan
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              weather.cityName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Temperature: ${weather.temperature} °C  ",
                      style: TextStyle(fontSize: 18, color: textColor),
                    ),
                    Image.asset(
                        getImagePath,
                        width: 50,
                        height: 50,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Humidité: ${weather.humidity} %  ",
                      style: TextStyle(fontSize: 18, color: textColor),
                    ),
                    Icon(
                      WeatherIcons.humidity,
                      size: 25,
                      color: textColor,
                    ),
                  ],
                ),

              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Vent: ${weather.windSpeed} km/h  ",
                  style: TextStyle(fontSize: 16, color: textColor),
                ),
                Icon(
                  WeatherIcons.strong_wind,
                  size: 25,
                  color: textColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
