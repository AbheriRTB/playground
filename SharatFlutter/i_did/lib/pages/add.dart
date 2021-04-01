import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  double _sliderDiscreteValue = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'ADD',
          style: GoogleFonts.bebasNeue(
            fontSize: 28.0,
            color: Colors.grey[700],
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.grey[600]),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(14),
                    ),
                    borderSide: BorderSide(
                      color: Colors.amber,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(14),
                    ),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.amber,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        labelStyle: TextStyle(color: Colors.grey[600]),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                          borderSide: BorderSide(
                            color: Colors.amber,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.amber,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Colors.grey[600]),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                          borderSide: BorderSide(
                            color: Colors.amber,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                spacing: 16.0,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 10.0, 16.0, 0.0),
                            child: Text(
                              'House',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                          Radio(
                            value: false,
                            onChanged: (val) {},
                            focusColor: Colors.green,
                            groupValue: null,
                          )
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 10.0, 16.0, 0.0),
                            child: Text(
                              'Work',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                          Radio(
                            value: false,
                            onChanged: (val) {},
                            focusColor: Colors.green,
                            groupValue: null,
                          )
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 10.0, 16.0, 0.0),
                            child: Text(
                              'Other',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                          Radio(
                            value: false,
                            onChanged: (val) {},
                            focusColor: Colors.green,
                            groupValue: null,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Slider(
              value: _sliderDiscreteValue,
              min: 0,
              max: 100,
              divisions: 100,
              activeColor: Colors.green[600],
              inactiveColor: Colors.green[100],
              label: _sliderDiscreteValue.round().toString(),
              onChanged: (value) {
                setState(() {
                  _sliderDiscreteValue = value;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(
          'Add',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.red[400],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
