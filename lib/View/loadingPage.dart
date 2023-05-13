import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:weather_app/Widgets/loadingBarWidgets.dart';
import '../Controllers/loadingController.dart';
import '../Widgets/weatherList.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final LoadingController loadingController = Get.put(LoadingController());
  Timer? _timer;
  //creer des variable pour couleur
  Color morningColor = Colors.orangeAccent;
  Color textColor = Colors.white;

  DateTime now = DateTime.now();
  int currentHour = DateTime.now().hour;

  String backgroundImage = "";



  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 11), (timer) {
      setState(() {});
    });
    if (currentHour >= 6 && currentHour < 12) {
      backgroundImage = "assets/images/morning.jpg";
      morningColor = Colors.cyanAccent;
      textColor = Colors.black ;
    } else if (currentHour >= 11 && currentHour < 18) {
      morningColor = Colors.orangeAccent;
      textColor = Colors.white;

      backgroundImage = "assets/images/afternoon.jpg";
    } else if (currentHour >= 18 && currentHour < 20) {
      morningColor = Colors.blueGrey;
      textColor = Colors.white;
      backgroundImage = "assets/images/evening.jpg";
    } else {
      morningColor = Colors.deepPurple;
      textColor = Colors.white;
      backgroundImage = "assets/images/night2.jpg";
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Weather App"),
        // changer couleur de text
        foregroundColor: textColor,
        centerTitle: true,
        backgroundColor: morningColor,
      ),
      body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage(backgroundImage),
    fit: BoxFit.cover,
    ),
    ),
    child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Obx(() => Visibility(
              visible: loadingController.isLoading.value,
              child: LoadingBarWidget(),
            )),

            Obx(() => Visibility(
              visible: loadingController.isLoading.value,
              child: Text(
                loadingController.messages[loadingController.counter.value],
                style:  TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: textColor,
                )
              ),
            )),
            const SizedBox(height: 20),
            Obx(() => Visibility(
              visible: !loadingController.isLoading.value,
              child: ElevatedButton(
                onPressed: loadingController.reset,
                style: ElevatedButton.styleFrom(
                  foregroundColor: textColor , backgroundColor: morningColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text("Recommencer"),
                ),
              ),
            )),

            const SizedBox(height: 20),
            Obx(() =>Expanded(
              child: ListView.builder(
                itemCount: loadingController.weatherList.length,
                itemBuilder: (context, index) {
                  final weather = loadingController.weatherList[index];
                  return WeatherListTile(weather: weather);
                },
              ),
            )),
          ],
        ),
      ),
    ),
    );
  }
}
