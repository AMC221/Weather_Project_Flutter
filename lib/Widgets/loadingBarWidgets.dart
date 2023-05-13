import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/loadingController.dart';

class LoadingBarWidget extends StatelessWidget {
  const LoadingBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoadingController loadingController = Get.put(LoadingController());

    return Visibility(
      visible: loadingController.isLoading.value,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: loadingController.progress.value / 100 * MediaQuery.of(context).size.width,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    Colors.yellowAccent,
                    Colors.orange,
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  '${loadingController.progress.value.round()}%',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
