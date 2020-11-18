import 'dart:convert';

import 'dart:js';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void getTime() async {
    // Make Request
    Response response =
        await get('http://worldtimeapi.org/timezone/Asia/Kolkata');
    Map data = jsonDecode(response.body);
    print(data);
    // Get Properties
    String dateTime = data['datetime'];
    String offset = data['utc_offset'];
  }

  @override
  void initState() {
    super.initState;
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
