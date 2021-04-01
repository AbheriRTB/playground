import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunaad_pen/assets/urls.dart';
import 'package:sunaad_pen/models/artiste.dart';
import 'package:sunaad_pen/models/organizers.dart';
import 'package:sunaad_pen/models/programs.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sunaad_pen/models/venue.dart';

class JasonData {
  Future<List<Programs>> fetchPrograms(http.Client client) async {
    return fetchPrograms2(client);
  }

  List<Programs> parseProgramsWithoutAsync(String responce) {
    return parseProgramsSync2(responce);
  }

  Future<List<Programs>> parseProgramsFromSPData() async {
    return parseProgramsFromSPData2();
  }

  Future<List<Artiste>> fetchArtisteDir(http.Client client) async {
    return fetchArtisteDir2(client);
  }

  Future<List<Artiste>> parseArtisteFromSPData() async {
    return parseArtisteFromSPData2();
  }

  Future<List<Venue>> fetchVenueDir(http.Client client) async {
    return fetchVenueDir2(client);
  }

  Future<List<Venue>> parseVenueFromSPData() async {
    return parseVenueFromSPData2();
  }

  Future<List<Organizer>> fetchOrganizerDir(http.Client client) async {
    return fetchOrganizerDir2(client);
  }

  Future<List<Organizer>> parseOrganizerFromSPData() async {
    return parseOrganizerFromSPData2();
  }
}

Future<List<Programs>> fetchPrograms2(http.Client client) async {
  final response = await client.get(Uri.parse(Urls().program()));

  // Use the compute function to run parsePhotos in a separate isolate.
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.getString('progsData');
  prefs.setString('progsData', response.body);

  return compute(parsePrograms, response.body);
}

// A function that converts a response body into a List<Photo>.
Future<List<Programs>> parsePrograms(String responseBody) async {
  final parsed = await jsonDecode(responseBody).cast<Map<String, dynamic>>();

  List<Programs> plist, newList;

  plist = parsed.map<Programs>((json) => Programs.fromJson(json)).toList();
  newList = processExpiredItems(plist);
  return newList;
}

// A function that converts a response body into a List<Photo>.
Future<List<Programs>> parseProgramsFromSPData2() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var respBody = prefs.getString("progsData");
  List<Programs> plist, newList;
  final parsed = jsonDecode(respBody).cast<Map<String, dynamic>>();
  plist = parsed.map<Programs>((json) => Programs.fromJson(json)).toList();
  newList = processExpiredItems(plist);

  return newList;
}

List<Programs> parseProgramsSync2(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

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

List<Artiste> processPublishedArtiste(List<Artiste> plist) {
  var experyDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day - 3);

  List<Artiste> newList = List<Artiste>();

  for (var i = 0; i < plist.length; ++i) {
    if (plist[i].artiste_is_published != 'No') {
      newList.add(plist[i]);
    }
  }
  return newList;
  //print("Length after:" + plist.length.toString());
}

Future<List<Artiste>> fetchArtisteDir2(http.Client client) async {
  final response = await client.get(Uri.parse(Urls().artiste()));

  // Use the compute function to run parsePhotos in a separate isolate.
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.getString('artisteData');
  prefs.setString('artisteData', response.body);

  return compute(parseArtisteDir, response.body);
}

// A function that converts a response body into a List<Artiste>.
Future<List<Artiste>> parseArtisteDir(String responseBody) async {
  final parsed = await jsonDecode(responseBody).cast<Map<String, dynamic>>();

  List<Artiste> plist, newList;
  plist = parsed.map<Artiste>((json) => Artiste.fromJson(json)).toList();
  newList = processPublishedArtiste(plist);
  return newList;
}

List<Artiste> parseArtisteSync2(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  List<Artiste> plist, newList;
  plist = parsed.map<Artiste>((json) => Artiste.fromJson(json)).toList();
  newList = processPublishedArtiste(plist);
  return newList;
}

// A function that converts a response body into a List<Photo>.
Future<List<Artiste>> parseArtisteFromSPData2() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var respBody = prefs.getString("artisteData");
  List<Artiste> plist, newList;
  final parsed = jsonDecode(respBody).cast<Map<String, dynamic>>();
  plist = parsed.map<Artiste>((json) => Artiste.fromJson(json)).toList();
  newList = processPublishedArtiste(plist);
  return newList;
}

List<Venue> processPublishedVenue(List<Venue> plist) {
  var experyDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day - 3);

  List<Venue> newList = List<Venue>();

  for (var i = 0; i < plist.length; ++i) {
    if (plist[i].venue_is_published != 'No') {
      newList.add(plist[i]);
    }
  }
  return newList;
  //print("Length after:" + plist.length.toString());
}

Future<List<Venue>> fetchVenueDir2(http.Client client) async {
  final response = await client.get(Uri.parse(Urls().venue()));

  // Use the compute function to run parsePhotos in a separate isolate.
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.getString('venueData');
  prefs.setString('venueData', response.body);

  return compute(parseVenueDir, response.body);
}

// A function that converts a response body into a List<Venue>.
Future<List<Venue>> parseVenueDir(String responseBody) async {
  final parsed = await jsonDecode(responseBody).cast<Map<String, dynamic>>();

  List<Venue> plist, newList;
  plist = parsed.map<Venue>((json) => Venue.fromJson(json)).toList();
  newList = processPublishedVenue(plist);
  return newList;
}

List<Venue> parseVenueSync2(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  List<Venue> plist, newList;
  plist = parsed.map<Venue>((json) => Venue.fromJson(json)).toList();
  newList = processPublishedVenue(plist);
  return newList;
}

// A function that converts a response body into a List<Photo>.
Future<List<Venue>> parseVenueFromSPData2() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var respBody = prefs.getString("venueData");
  List<Venue> plist, newList;
  final parsed = jsonDecode(respBody).cast<Map<String, dynamic>>();
  plist = parsed.map<Venue>((json) => Venue.fromJson(json)).toList();
  newList = processPublishedVenue(plist);
  return newList;
}

List<Organizer> processPublishedOrganizer(List<Organizer> plist) {
  var experyDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day - 3);

  List<Organizer> newList = List<Organizer>();

  for (var i = 0; i < plist.length; ++i) {
    if (plist[i].organizer_is_published != 'No') {
      newList.add(plist[i]);
    }
  }
  return newList;
  //print("Length after:" + plist.length.toString());
}

Future<List<Organizer>> fetchOrganizerDir2(http.Client client) async {
  final response = await client.get(Uri.parse(Urls().orgnizers()));

  // Use the compute function to run parsePhotos in a separate isolate.
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.getString('organizerData');
  prefs.setString('organizerData', response.body);

  return compute(parseOrganizerDir, response.body);
}

// A function that converts a response body into a List<Organizer>.
Future<List<Organizer>> parseOrganizerDir(String responseBody) async {
  final parsed = await jsonDecode(responseBody).cast<Map<String, dynamic>>();

  List<Organizer> plist, newList;
  plist = parsed.map<Organizer>((json) => Organizer.fromJson(json)).toList();
  newList = processPublishedOrganizer(plist);
  return newList;
}

List<Organizer> parseOrganizerSync2(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  List<Organizer> plist, newList;
  plist = parsed.map<Organizer>((json) => Organizer.fromJson(json)).toList();
  newList = processPublishedOrganizer(plist);
  return newList;
}

// A function that converts a response body into a List<Photo>.
Future<List<Organizer>> parseOrganizerFromSPData2() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var respBody = prefs.getString("organizerData");
  List<Organizer> plist, newList;
  final parsed = jsonDecode(respBody).cast<Map<String, dynamic>>();
  plist = parsed.map<Organizer>((json) => Organizer.fromJson(json)).toList();
  newList = processPublishedOrganizer(plist);
  return newList;
}
