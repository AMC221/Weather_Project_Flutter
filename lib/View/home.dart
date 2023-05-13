import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'loadingPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  late Timer _timer;

  final List<String> imagePaths = [
    'assets/images/01d.png',
    'assets/images/01n.png',
    'assets/images/09n.png',
    'assets/images/10d.png',
    'assets/images/11d.png',
    'assets/images/13d.png'
  ];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentPage < imagePaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body:Container(
    decoration: const BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/gifs/gif2.gif'),
    opacity: 0.7,
    fit: BoxFit.cover,
    ),
    ),
      child:Center(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenue sur Main Weather',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "S'il fait chaud, s'il fait froid, vous le saurez près de chez vous",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 100,
              child: PageView.builder(
                controller: _pageController,
                itemCount: imagePaths.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    imagePaths[index],
                    width: 80,
                    height: 80,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.to(LoadingPage()),

              child: const Text('Charger les données'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 10,
                padding: const EdgeInsets.all(15),
                primary: Colors.orangeAccent,
                onPrimary: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ),
          ],
        ),
      ),
    ),
    );
  }
}
