import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:sunaad/models/programs.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  Programs programInfo;
  InfoPage({
    this.programInfo,
  });

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  String imageUrl = 'https://abheri.pythonanywhere.com/static/images/';

  String defaultUrl =
      'https://abheri.pythonanywhere.com/static/images/default2.jpg';
  @override
  Widget build(BuildContext context) {
    String url = widget.programInfo.entry_fee;
    setState(() {
      //url = url.replaceAll('<a href="', '');
      //url = url.replaceAll('">Click here </a>', '');
      //url = url.replaceAll('">Register here </a>', '');
      url = url.substring(url.indexOf("\"") + 1, url.lastIndexOf("\""));
    });

    if (widget.programInfo.artiste_image.isNotEmpty) {
      defaultUrl = imageUrl + widget.programInfo.artiste_image;
    } else {
      defaultUrl =
          'https://abheri.pythonanywhere.com/static/images/default2.jpg';
    }

    var formatter = DateFormat('dd-MM-yyyy');
    var formatterTime = DateFormat('hh:mm a');
    String formattedDate = formatter.format(widget.programInfo.event_date);
    String formattedTime = formatterTime.format(widget.programInfo.event_date);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Event",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.white,
                        )),
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 6.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.fastfood,
                          color: Colors.white,
                        )),
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 6.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.local_parking,
                          color: Colors.white,
                        )),
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 6.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.timer,
                          color: Colors.white,
                        )),
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 6.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: InkWell(
                    onTap: () async {
                      _launchURL(url.trim());
                    },
                    child: Container(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.public,
                            color: Colors.white,
                          )),
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(54, 14, 54, 26),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(defaultUrl,
                  height: 300.0, width: 300.0, fit: BoxFit.cover),
            ),
          ),
          Text(
            widget.programInfo.title,
            style: TextStyle(color: Colors.grey[600], fontSize: 18),
          ),
          SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.programInfo.description,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0.0),
            child: Text(
              'On ${formattedDate}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'At ${formattedTime}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.0),
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              _launchURL(url.trim());
            },
            child: Text(
              'ATTEND',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 36.0),
        ]),
      ),
    );
  }

  _launchURL(String url) async {
    print(url);
    if (url.isNotEmpty) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      print('NoData');
    }
  }
}
