import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_covid_app/views/home.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      Get.to(() => Home());
      // Get.toEnd(() => Home());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: Get.height * 0.2,
            ),
            Container(
              // height: Get.height * 0.3,
              // width: Get.height * 0.3,
              // color: Colors.white,
              child: Image.asset(
                "assets/covid.jpg",
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
            Center(
                child: Text(
              "COVID-19\nTracker App",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )),
          ],
        ),
      ),
    );
  }
}
