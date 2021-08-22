import 'package:flutter/material.dart';
import 'package:kaksha/models/model_explain.dart';
import 'package:kaksha/widgets/list_tile.dart';

class ExplanationPage extends StatefulWidget {
  List<Explain>? list = [];
  ExplanationPage({this.list});

  @override
  _ExplanationPageState createState() => _ExplanationPageState();
}

class _ExplanationPageState extends State<ExplanationPage> {
  Color background = Color.fromRGBO(253, 246, 227, 1);
  Color background2 = Color.fromRGBO(233, 229, 205, 1);
  Color accent = Color.fromRGBO(218, 117, 68, 1);

  bool selected = false;
  String sanTrans = 'Sanskrit comes here.';
  String engTrans = 'English translation comes here.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explanation',
                style: TextStyle(
                  fontSize: 36.0,
                  color: Colors.cyan[700],
                ),
              ),
              Text(
                'विषय',
                style: TextStyle(
                  fontSize: 28.0,
                  color: Colors.cyan[700],
                  fontFamily: 'Hind',
                ),
              ),
              SizedBox(
                height: 34.0,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: widget.list!.length,
                    itemBuilder: (context, index) {
                      return CustomList.listTypeOne(
                        onTap: () {
                          setState(() {
                            widget.list!.forEach((element) {
                              element.isSelected = false;
                            });
                            bool? val = widget.list![index].isSelected;
                            widget.list![index].isSelected = !val!;
                            sanTrans = widget.list![index].sanTrans.toString();
                            engTrans = widget.list![index].engTrans.toString();
                          });
                        },
                        list: widget.list![index],
                      );
                    }),
              ),
              Flexible(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Wrap(
                      children: [
                        Container(
                          color: accent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              sanTrans,
                              style: TextStyle(
                                fontSize: 28.0,
                              ),
                            ),
                          ),
                          width: double.infinity,
                        ),
                        Container(
                          color: background2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              engTrans,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          width: double.infinity,
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: background,
    );
  }
}
