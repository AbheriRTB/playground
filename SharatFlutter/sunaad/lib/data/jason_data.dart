import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunaad/models/programs.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class JasonData {
  Future<List<Programs>> fetchPrograms(http.Client client) async {
    return fetchPrograms2(client);
  }
}

Future<List<Programs>> fetchPrograms2(http.Client client) async {
  final response =
      await client.get('https://sunaad-services-njs.herokuapp.com/getPrograms');

  // Use the compute function to run parsePhotos in a separate isolate.
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.getString('progsData');
  prefs.setString('progsData', response.body);

  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
Future<List<Programs>> parsePhotos(String responseBody) async {
  final parsed = await jsonDecode(responseBody).cast<Map<String, dynamic>>();

  List<Programs> plist, newList;

  plist = parsed.map<Programs>((json) => Programs.fromJson(json)).toList();
  newList = processExpiredItems(plist);
  return newList;
}

List<Programs> processExpiredItems(List<Programs> plist) {
  var experyDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day - 3);

  List<Programs> newList = List<Programs>();

  for (var i = 0; i < plist.length; ++i) {
    if (!experyDate.isAfter(plist[i].event_date) &&
        plist[i].is_published != 'No') {
      newList.add(plist[i]);
    }
  }
  return newList;
  //print("Length after:" + plist.length.toString());
}
