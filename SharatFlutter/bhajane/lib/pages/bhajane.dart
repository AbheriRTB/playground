import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BhjanePage extends StatefulWidget {
  @override
  _BhjanePageState createState() => _BhjanePageState();
}

class _BhjanePageState extends State<BhjanePage> {
  String lyrics, txt;
  Map data = {};
  fetchFileData() async {
    String responceText;
    responceText = await rootBundle.loadString("lib/bhajanes/${data['txt']}");

    setState(() {
      lyrics = responceText;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    fetchFileData();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        mini: true,
        child: Icon(Icons.arrow_right),
        elevation: 0,
        backgroundColor: Colors.grey[300],
        onPressed: () {},
      ),
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                  child: Text(
                    data['name'],
                    style: TextStyle(
                      fontSize: 36,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 12.0),
                  child: Text(
                    lyrics,
                    style: TextStyle(fontSize: 14, fontFamily: 'BalooTamma'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
