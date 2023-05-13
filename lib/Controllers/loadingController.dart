import 'dart:async';
import 'package:get/get.dart';
import '../Models/weather.dart';
import '../Services/weatherService.dart';

class LoadingController extends GetxController {
  var progress = 0.0.obs;
  var isLoading = true.obs;
  var counter = 0.obs;
  var messages = [
    "Nous téléchargeons les données...",
    "C'est presque fini...",
    "Plus que quelques secondes avant d'avoir le résultat..."
  ].obs;
  var weatherList = <Weather>[].obs;

  late Timer _timer; // Ajout d'une variable pour stocker le Timer
  late Timer _messageTimer; // Ajout d'une variable pour stocker le Timer des messages

  @override
  void onReady() {
    super.onReady();
    startLoading(); // Appel de la fonction startLoading au démarrage du contrôleur
  }

  Future<void> loadData(String cityName) async {
    final weather = await WeatherService.fetchWeather(cityName);
    weatherList.add(weather);

    progress.value = ((weatherList.length) * 100 / 5).toDouble();

    if (weatherList.length == 5) {
      _timer.cancel(); // Arrêt du Timer après 5 appels
      isLoading.value = false;
    }
  }

  void startLoading() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      const cities = ["Paris", "Diourbel", "Dakar", "Moscou", "Toronto"];
      loadData(cities[timer.tick - 1]);
    });

    _messageTimer = Timer.periodic(Duration(seconds: 6), (timer) {
      if (timer.tick >= 10) {
        _messageTimer.cancel(); // Arrêt du Timer des messages après 60 secondes
      } else {
        counter.value = (counter.value + 1) % 3;
      }
    });

    Timer(Duration(seconds: 60), () {
      _timer.cancel(); // Arrêt du Timer après 60 secondes
      isLoading.value = false;
      _messageTimer.cancel(); // Arrêt du Timer des messages après 60 secondes
    });
  }

  void reset() {
    _timer.cancel(); // Arrêt du Timer en cas de reset
    _messageTimer.cancel(); // Arrêt du Timer des messages en cas de reset
    progress.value = 0.0;
    isLoading.value = true;
    counter.value = 0;
    weatherList.clear();
    startLoading(); // Relancer le chargement de données
  }
}
