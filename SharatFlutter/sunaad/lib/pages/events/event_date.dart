import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sunaad/data/jason_data.dart';
import 'package:sunaad/data/data_utils.dart';
import 'package:sunaad/pages/settings.dart';
import 'package:sunaad/utils/drawer.dart';
import 'package:sunaad/utils/list_tile.dart';
import 'package:http/http.dart' as http;
import 'package:sunaad/models/programs.dart';
import 'package:dart_date/dart_date.dart';

class EventDatePage extends StatefulWidget {
  int indexToScroll;
  @override
  _EventDatePageState createState() => _EventDatePageState();
}

Future<List<Programs>> fetchPrograms(http.Client client) async {
  final response =
      await client.get('https://sunaad-services-njs.herokuapp.com/getPrograms');

  // Use the compute function to run parsePhotos in a separate isolate.

  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Programs> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  List<Programs> plist, newList;
  plist = parsed.map<Programs>((json) => Programs.fromJson(json)).toList();
  print("Length before:" + plist.length.toString());
  newList = processExpiredItems(plist);
  print("Length after:" + newList.length.toString());
  return newList;
}

List<Programs> processExpiredItems(List<Programs> plist) {
  var experyDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day - 3);

  List<Programs> newList = List<Programs>();

  for (var i = 0; i < plist.length; ++i) {
    if (!experyDate.isAfter(plist[i].event_date) &&
        plist[i].is_published != 'No') {
      print(plist[i].event_date);
      newList.add(plist[i]);
    }
  }
  //newList = JasonData().parsePhotos();
  return newList;
  //print("Length after:" + plist.length.toString());
}

class _EventDatePageState extends State<EventDatePage> {
  AutoScrollController controller;
  JasonData jasonData = JasonData();
  DataUtils dataUtils = DataUtils();

  int indexToScroll = -1;
  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.horizontal);
  }

  String imageUrl = 'https://abheri.pythonanywhere.com/static/images/';
  String defaultUrl =
      'https://abheri.pythonanywhere.com/static/images/default2.jpg';
  bool isFinished = false;
  bool isToday = false;
  List<Programs> progs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Concerts",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          )
        ],
      ),
      drawer: MyDrawer(
        pos: 1,
      ),
      body: Container(
        child: FutureBuilder<List<Programs>>(
          future: JasonData().fetchPrograms(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListView.builder(
                    controller: controller,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      progs = snapshot.data;
                      for (var i = 0; i < progs.length; ++i) {
                        if (progs[i].event_date.isSameDay(DateTime.now()) &&
                            indexToScroll == -1) {
                          indexToScroll = i;
                        }
                      }
                      if (indexToScroll != -2) {
                        _scrollToIndex(indexToScroll);
                        indexToScroll = -2;
                      }
                      return AutoScrollTag(
                        key: ValueKey(index),
                        controller: controller,
                        index: index,
                        child: DefaultList(
                          progs: progs[index],
                        ),
                      );
                    })
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Future _scrollToIndex(int index) async {
    await controller.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin,
        duration: Duration(seconds: 3));
  }
}
