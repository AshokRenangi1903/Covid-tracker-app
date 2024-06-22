import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_covid_app/controllers/country_stats_controller.dart';
import 'package:flutter_covid_app/views/each_coutry_stats.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  CountryStatsController countryStatsController = CountryStatsController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // title: Text("countries list"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                hintText: "Search with country name",
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: countryStatsController.fetchCountryStats(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade500,
                            highlightColor: Colors.grey.shade300,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                    height: 10,
                                    width: 20,
                                    color: Colors.grey.shade300,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 120,
                                    color: Colors.grey.shade300,
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          String countryName = snapshot.data[index]['country'];
                          if (searchController.text.isEmpty) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(() => EachCountryStats(
                                          countryName: countryName,
                                          image: snapshot.data[index]
                                              ['countryInfo']['flag'],
                                          totalCases: snapshot.data[index]
                                              ['cases'],
                                          totalDeaths: snapshot.data[index]
                                              ['deaths'],
                                          totalRecovered: snapshot.data[index]
                                              ['recovered'],
                                          active: snapshot.data[index]
                                              ['active'],
                                        ));
                                  },
                                  child: ListTile(
                                    title: Text(countryName),
                                    subtitle: Text(snapshot.data[index]['cases']
                                        .toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(
                                        snapshot.data[index]['countryInfo']
                                            ['flag'],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (countryName.toLowerCase().startsWith(
                              searchController.text.toLowerCase())) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(() => EachCountryStats(
                                          countryName: countryName,
                                          image: snapshot.data[index]
                                              ['countryInfo']['flag'],
                                          totalCases: snapshot.data[index]
                                              ['cases'],
                                          totalDeaths: snapshot.data[index]
                                              ['deaths'],
                                          totalRecovered: snapshot.data[index]
                                              ['recovered'],
                                          active: snapshot.data[index]
                                              ['active'],
                                        ));
                                  },
                                  child: ListTile(
                                    title: Text(countryName),
                                    subtitle: Text(snapshot.data[index]['cases']
                                        .toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(
                                        snapshot.data[index]['countryInfo']
                                            ['flag'],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}
