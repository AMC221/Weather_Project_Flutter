import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'View/home.dart';
import 'View/splash.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      home: SplashScreenPage(),
    );
  }
}