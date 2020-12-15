import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BhjanePage extends StatefulWidget {
  @override
  _BhjanePageState createState() => _BhjanePageState();
}

class _BhjanePageState extends State<BhjanePage> {
  String lyrics, txt;
  Map data = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    return Page1(data: data);
  }
}

class Page1 extends StatefulWidget {
  const Page1({
    Key key,
    @required this.data,
  }) : super(key: key);

  final Map data;

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  String lyrics;
  Widget build(BuildContext context) {
    fetchFileData(String text) async {
      String responceText;
      responceText = await rootBundle.loadString("lib/bhajanes/$text}");

      setState(() {
        lyrics = responceText;
      });
    }

    fetchFileData("lib/bhajanes/page1");

    return Bhajane(data: widget.data, lyrics: lyrics);
  }
}

class Bhajane extends StatelessWidget {
  const Bhajane({
    Key key,
    @required this.data,
    @required this.lyrics,
  }) : super(key: key);

  final Map data;
  final String lyrics;

  @override
  Widget build(BuildContext context) {
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
