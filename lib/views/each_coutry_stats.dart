
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_covid_app/views/home.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EachCountryStats extends StatefulWidget {
  var countryName, totalCases, image, totalDeaths, totalRecovered, active;

  EachCountryStats({
    super.key,
    required this.countryName,
    this.totalCases,
    this.image,
    this.totalDeaths,
    this.totalRecovered,
    this.active,
  });

  @override
  State<EachCountryStats> createState() => _EachCountryStatsState();
}

class _EachCountryStatsState extends State<EachCountryStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.countryName),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.12),
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.06,
                          ),
                          ReusableRow(
                              title: "Cases",
                              value: widget.totalCases.toString()),
                          ReusableRow(
                              title: "Recovered",
                              value: widget.totalRecovered.toString()),
                          ReusableRow(
                              title: "Deaths",
                              value: widget.totalDeaths.toString()),
                          ReusableRow(
                              title: "Active", value: widget.active.toString()),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: CircleAvatar(
                      radius: Get.width / 7,
                      backgroundImage: NetworkImage(widget.image),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
