import 'package:chalk_board/pages/public/home.dart';
import 'package:chalk_board/services/auth.dart';
import 'package:chalk_board/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  List<String> stringData = [
    'MINS',
    'HRS',
  ];
  String unit = 'HRS';
  int index;
  TextEditingController dishController = TextEditingController(),
      recipieController = TextEditingController(),
      durationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 24.0),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(32.0),
              bottomLeft: Radius.circular(32.0),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.2),
              height: double.infinity,
              width: double.infinity,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Recipie',
                          style: TextStyle(
                            fontFamily: GoogleFonts.indieFlower().fontFamily,
                            color: Colors.amber,
                            backgroundColor: Colors.grey[900],
                            fontSize: 40.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: dishController,
                          style: TextStyle(
                            fontFamily: GoogleFonts.indieFlower().fontFamily,
                            color: Colors.amber,
                            fontSize: 20.0,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Dish Name',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(
                              fontFamily: GoogleFonts.indieFlower().fontFamily,
                              color: Colors.amber,
                              backgroundColor: Colors.grey[900],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          controller: recipieController,
                          textInputAction: TextInputAction.newline,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: GoogleFonts.indieFlower().fontFamily,
                            color: Colors.amber,
                            fontSize: 20.0,
                          ),
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            labelText: 'Enter the recipie here',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(
                              fontFamily: GoogleFonts.indieFlower().fontFamily,
                              color: Colors.amber,
                              backgroundColor: Colors.grey[900],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                              maxLength: 2,
                              keyboardType: TextInputType.number,
                              controller: durationController,
                              style: TextStyle(
                                fontFamily:
                                    GoogleFonts.indieFlower().fontFamily,
                                color: Colors.amber,
                              ),
                              decoration: InputDecoration(
                                counterText: "",
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                labelText: 'Duration',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelStyle: TextStyle(
                                  fontFamily:
                                      GoogleFonts.indieFlower().fontFamily,
                                  color: Colors.amber,
                                  backgroundColor: Colors.grey[900],
                                ),
                                suffix: TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            title: Text('Units'),
                                            backgroundColor: Colors.grey[900],
                                            contentPadding: EdgeInsets.zero,
                                            content: StatefulBuilder(
                                                // You need this, notice the parameters below:
                                                builder: (BuildContext context,
                                                    StateSetter setState) {
                                              setState = setState;
                                              return SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    for (int i = 0;
                                                        i < stringData.length;
                                                        ++i)
                                                      RadioListTile(
                                                        value: i,
                                                        groupValue: index,
                                                        selected: true,
                                                        title: Text(
                                                          stringData[i],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        onChanged: (pos) {
                                                          index = pos;
                                                          setState(() {});
                                                        },
                                                      ),
                                                  ],
                                                ),
                                              );
                                            }),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                  setState(() {
                                                    unit = stringData[index];
                                                  });
                                                },
                                                child: Text('SUBMIT'),
                                                style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    primary: Colors.amber),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Text(
                                    unit,
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.indieFlower().fontFamily,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            DatabaseService(uid: await AuthService().getUID()).createPost(
                dishController.text.toString(),
                recipieController.text.toString(),
                int.parse(durationController.text),
                unit);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return HomePage();
                },
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.grey[800],
          ),
          backgroundColor: Colors.amber.withOpacity(0.7)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
