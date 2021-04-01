import 'package:bhajane/models/bhajane.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class LyricsPage extends StatefulWidget {
  List<Bhajane> bhajane;
  int i;
  LyricsPage(this.bhajane, this.i);
  @override
  _LyricsPageState createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;
  String data;
  String location;
  bool _right_enabeled = false, _left_enabeled = false;

  fetchFileData() async {
    location = widget.bhajane[widget.i].location;
    String responceText;
    responceText = await rootBundle.loadString('lib/lyrics/$location');
    setState(() {
      data = responceText;
    });
  }

  @override
  void initState() {
    fetchFileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      widget.bhajane[widget.i].kannada,
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                  GestureDetector(
                    onScaleStart: (details) {
                      _baseScaleFactor = _scaleFactor;
                    },
                    onScaleUpdate: (details) {
                      setState(() {
                        _scaleFactor = _baseScaleFactor * details.scale;
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        data,
                        style: TextStyle(fontSize: 14),
                        textScaleFactor: _scaleFactor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Visibility(
          visible: enabeled_left(),
          child: FloatingActionButton(
            onPressed: () {
              print('hello');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LyricsPage(widget.bhajane, widget.i - 1)),
              );
            },
            mini: true,
            child: Icon(Icons.arrow_left_outlined),
            backgroundColor: Colors.lightGreen,
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartFloat,
      ),
      floatingActionButton: Visibility(
        visible: enabeled_right(),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LyricsPage(widget.bhajane, widget.i + 1)),
            );
          },
          mini: true,
          child: Icon(Icons.arrow_right_outlined),
          backgroundColor: Colors.lightGreen,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  bool enabeled_left() {
    if (widget.i - 1 >= 0) {
      setState(() {
        _left_enabeled = true;
      });
    }
    return _left_enabeled;
  }

  bool enabeled_right() {
    if (widget.i + 1 < widget.bhajane.length) {
      _right_enabeled = true;
    }
    return _right_enabeled;
  }
}
