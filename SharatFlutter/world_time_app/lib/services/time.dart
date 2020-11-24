import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  String location; // Location name for UI
  String time; // Time in that location
  String flag; // URL to asset flag icon
  String url; // Location URL for API end point

  WorldTime({this.location, this.time, this.flag, this.url});

  Future<void> getTime() async {
    // Make the request
    Response response = await get('http://worldtimeapi.org/timezone/$url');
    Map data = jsonDecode(response.body);

    // Get properties from json
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);

    // Create DateTime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    // Set time property
    time = now.toString();
  }
}
