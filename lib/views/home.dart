// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_covid_app/controllers/theme_controller.dart';
import 'package:flutter_covid_app/controllers/world_stats_controller.dart';
import 'package:flutter_covid_app/views/countries_list.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pie_chart/pie_chart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ThemeController themeController = Get.put(ThemeController());
  WorldStatsController worldStatsController = WorldStatsController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              FutureBuilder(
                  future: worldStatsController.fetchWorldStats(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        height: Get.height,
                        child: SpinKitCircle(
                          color: Colors.green,
                          size: 100,
                        ),
                      );
                    } else {
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PieChart(
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              dataMap: {
                                "Total": double.parse(
                                    snapshot.data!.cases.toString()),
                                "Recovered": double.parse(
                                    snapshot.data!.recovered.toString()),
                                "Death": double.parse(
                                    snapshot.data!.deaths.toString()),
                              },
                              chartRadius: Get.width / 3,
                              chartType: ChartType.ring,
                              legendOptions: LegendOptions(
                                  legendPosition: LegendPosition.left),
                              colorList: [
                                Colors.blue,
                                Colors.green,
                                Colors.red,
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  Get.width * 0.1, 20, Get.width * 0.1, 20),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.4),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: Column(
                                children: [
                                  ReusableRow(
                                      title: "Total",
                                      value: snapshot.data!.cases.toString()),
                                  ReusableRow(
                                      title: "Deaths",
                                      value: snapshot.data!.deaths.toString()),
                                  ReusableRow(
                                      title: "Recovered",
                                      value:
                                          snapshot.data!.recovered.toString()),
                                  ReusableRow(
                                      title: "Today Cases",
                                      value:
                                          snapshot.data!.todayCases.toString()),
                                  ReusableRow(
                                      title: "Critical",
                                      value:
                                          snapshot.data!.critical.toString()),
                                  ReusableRow(
                                      title: "Tests",
                                      value: snapshot.data!.tests.toString()),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => CountriesList());
                              },
                              child: Container(
                                child: Center(
                                    child: Text(
                                  "Track Countries",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                                width: Get.width * 0.8,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          onPressed: () {
            themeController.setTheme();
          },
          child: (themeController.isLight.value == true)
              ? Icon(Icons.dark_mode)
              : Icon(Icons.sunny),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
