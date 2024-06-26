import 'dart:convert';

import 'package:flutter_covid_app/resources/app_urls.dart';
import 'package:http/http.dart' as http;

class CountryStatsController {
  Future fetchCountryStats() async {
    final response = await http.get(Uri.parse(AppUrls.countriesUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
