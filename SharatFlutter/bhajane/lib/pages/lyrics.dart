import 'package:bhajane/models/bhajane.dart';
import 'package:bhajane/models/shloka.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class BhjaneLyricsPage extends StatefulWidget {
  List<Bhajane> bhajane;
  int i;
  BhjaneLyricsPage(this.bhajane, this.i);

  @override
  _BhajaneLyricsPageState createState() => _BhajaneLyricsPageState();
}

class _BhajaneLyricsPageState extends State<BhjaneLyricsPage> {
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

  Color color = Color.fromRGBO(145, 47, 0, 0.8);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      widget.bhajane[widget.i].kannada,
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      onScaleStart: (details) {
                        _baseScaleFactor = _scaleFactor;
                      },
                      onScaleUpdate: (details) {
                        setState(() {
                          _scaleFactor = _baseScaleFactor * details.scale;
                        });
                      },
                      child: Text(
                        data,
                        style: TextStyle(fontSize: 16),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BhjaneLyricsPage(widget.bhajane, widget.i - 1)),
              );
            },
            mini: true,
            child: Icon(Icons.arrow_left_outlined),
            backgroundColor: color,
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
                      BhjaneLyricsPage(widget.bhajane, widget.i + 1)),
            );
          },
          mini: true,
          child: Icon(Icons.arrow_right_outlined),
          backgroundColor: color,
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

class ShlokaLyricsPage extends StatefulWidget {
  List<Shloka> shloka = [];
  int i;
  ShlokaLyricsPage(this.shloka, this.i);
  @override
  _ShlokaLyricsPageState createState() => _ShlokaLyricsPageState();
}

class _ShlokaLyricsPageState extends State<ShlokaLyricsPage> {
  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;
  String data;
  String location;
  bool _right_enabeled = false, _left_enabeled = false;

  fetchFileData() async {
    location = widget.shloka[widget.i].location;
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
    Color color = Color.fromRGBO(145, 47, 0, 0.8);
    return Scaffold(
      body: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      widget.shloka[widget.i].kannada,
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      onScaleStart: (details) {
                        _baseScaleFactor = _scaleFactor;
                      },
                      onScaleUpdate: (details) {
                        setState(() {
                          _scaleFactor = _baseScaleFactor * details.scale;
                        });
                      },
                      child: Text(
                        data,
                        style: TextStyle(fontSize: 16),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ShlokaLyricsPage(widget.shloka, widget.i - 1)),
              );
            },
            mini: true,
            child: Icon(Icons.arrow_left_outlined),
            backgroundColor: color,
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
                      ShlokaLyricsPage(widget.shloka, widget.i + 1)),
            );
          },
          mini: true,
          child: Icon(Icons.arrow_right_outlined),
          backgroundColor: color,
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
    if (widget.i + 1 < widget.shloka.length) {
      _right_enabeled = true;
    }
    return _right_enabeled;
  }
}
