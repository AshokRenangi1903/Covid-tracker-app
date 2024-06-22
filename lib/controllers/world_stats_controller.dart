import 'dart:convert';

import 'package:flutter_covid_app/models/world_states_model.dart';
import 'package:flutter_covid_app/resources/app_urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WorldStatsController {
  Future fetchWorldStats() async {
    final response = await http.get(Uri.parse(AppUrls.worldUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }
}
