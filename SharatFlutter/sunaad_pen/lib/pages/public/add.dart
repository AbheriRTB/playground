import 'package:flutter/material.dart';
import 'package:sunaad_pen/data/jason_data.dart';
import 'package:sunaad_pen/models/artiste.dart';
import 'package:sunaad_pen/models/organizers.dart';
import 'package:sunaad_pen/models/venue.dart';
import 'package:sunaad_pen/utils/text_input_signin.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  int index = 1;
  String artiste = 'Select Artiste',
      date = 'Select Date',
      organizer = 'Select Organizer',
      venue = 'Select Venue',
      startTime = 'Select Start Time',
      endTime = 'Select End Time',
      artType = 'Select Event Type';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lime[700],
        accentColor: Colors.red[400],
        buttonColor: Colors.red[300],
      ),
      home: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "ADD CONCERT",
                    style: TextStyle(
                      fontSize: 34,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                      backgroundColor: Colors.lime[200],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: textInputDecoration('Title'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: textInputDecoration('Description'),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Date:'),
                      OutlinedButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime(2020, 11, 17),
                            firstDate: DateTime(2017, 1),
                            lastDate: DateTime(2022, 7),
                            helpText: 'Select a date',
                          );
                        },
                        child: Text(date),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Artiste:'),
                      FutureBuilder<List<Artiste>>(
                        future: JasonData().parseArtisteFromSPData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          if (snapshot.hasData) {
                            List<String> stringData = [];
                            for (int i = 0; i < snapshot.data.length; ++i) {
                              stringData.add(snapshot.data[i].artiste_name);
                            }
                            stringData.sort();
                            return OutlinedButton(
                              child: Text(artiste),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        title: Text('Select Artist'),
                                        contentPadding: EdgeInsets.zero,
                                        content: StatefulBuilder(
                                            // You need this, notice the parameters below:
                                            builder: (BuildContext context,
                                                StateSetter setState) {
                                          setState = setState;
                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                for (int i = 1;
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
                                                              Colors.grey[800]),
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
                                          FlatButton(
                                            onPressed: () => Navigator.of(
                                                    context,
                                                    rootNavigator: true)
                                                .pop(),
                                            child: Text(
                                              'CANCEL',
                                              style: TextStyle(
                                                  color: Colors.red[300]),
                                            ),
                                          ),
                                          OutlinedButton(
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();

                                              setState(() {
                                                artiste = stringData[index];
                                              });
                                            },
                                            child: Text('SUBMIT'),
                                            style: OutlinedButton.styleFrom(
                                                elevation: 0,
                                                primary: Colors.red[300]),
                                          ),
                                        ],
                                      );
                                    });
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Organizer:'),
                      FutureBuilder<List<Organizer>>(
                          future: JasonData().parseOrganizerFromSPData(),
                          builder: (context, snapshot) {
                            List<String> stringData = [];
                            if (snapshot.hasError) print(snapshot.error);
                            if (snapshot.hasData) {
                              List<String> stringData = [];
                              for (int i = 0; i < snapshot.data.length; ++i) {
                                stringData.add(snapshot.data[i].organizer_name);
                              }
                              return OutlinedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            title: Text('Select an Organizer'),
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
                                                    for (int i = 1;
                                                        i < stringData.length;
                                                        ++i)
                                                      RadioListTile(
                                                        value: i,
                                                        groupValue: index,
                                                        selected: true,
                                                        title: Text(
                                                          stringData[i],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[800]),
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
                                              FlatButton(
                                                onPressed: () => Navigator.of(
                                                        context,
                                                        rootNavigator: true)
                                                    .pop(),
                                                child: Text(
                                                  'CANCEL',
                                                  style: TextStyle(
                                                      color: Colors.red[300]),
                                                ),
                                              ),
                                              OutlinedButton(
                                                onPressed: () {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();

                                                  setState(() {
                                                    organizer =
                                                        stringData[index];
                                                  });
                                                },
                                                child: Text('SUBMIT'),
                                                style: OutlinedButton.styleFrom(
                                                    elevation: 0,
                                                    primary: Colors.red[300]),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Text(organizer));
                            } else {
                              return Container(
                                child: Text(snapshot.error.toString()),
                              );
                            }
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Venue:'),
                      FutureBuilder<List<Venue>>(
                          future: JasonData().parseVenueFromSPData(),
                          builder: (context, snapshot) {
                            List<String> stringData = [];
                            if (snapshot.hasError) print(snapshot.error);
                            if (snapshot.hasData) {
                              List<String> stringData = [];
                              for (int i = 0; i < snapshot.data.length; ++i) {
                                stringData.add(snapshot.data[i].venue_name);
                              }
                              return OutlinedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            title: Text('Select a Venue'),
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
                                                    for (int i = 1;
                                                        i < stringData.length;
                                                        ++i)
                                                      RadioListTile(
                                                        value: i,
                                                        groupValue: index,
                                                        selected: true,
                                                        title: Text(
                                                          stringData[i],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[800]),
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
                                              FlatButton(
                                                onPressed: () => Navigator.of(
                                                        context,
                                                        rootNavigator: true)
                                                    .pop(),
                                                child: Text(
                                                  'CANCEL',
                                                  style: TextStyle(
                                                      color: Colors.red[300]),
                                                ),
                                              ),
                                              OutlinedButton(
                                                onPressed: () {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();

                                                  setState(() {
                                                    venue = stringData[index];
                                                  });
                                                },
                                                child: Text('SUBMIT'),
                                                style: OutlinedButton.styleFrom(
                                                    elevation: 0,
                                                    primary: Colors.red[300]),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Text(venue));
                            } else {
                              return Container(
                                child: Text(snapshot.error.toString()),
                              );
                            }
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Start-Time:'),
                      OutlinedButton(
                        onPressed: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(hour: 7, minute: 15),
                            initialEntryMode: TimePickerEntryMode.dial,
                          );
                        },
                        child: Text(startTime),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('End-Time:'),
                      OutlinedButton(
                        onPressed: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(hour: 7, minute: 15),
                            initialEntryMode: TimePickerEntryMode.dial,
                          );
                        },
                        child: Text(endTime),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Art Type:'),
                      OutlinedButton(
                          onPressed: () {
                            final stringData = [
                              'Carnatic',
                              'Hindustani',
                              'Jugalbandi',
                              'Dance',
                              'Lecture',
                              'Humour',
                              'Drama',
                            ];
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text('Select Art Type'),
                                    contentPadding: EdgeInsets.zero,
                                    content: StatefulBuilder(
                                        // You need this, notice the parameters below:
                                        builder: (BuildContext context,
                                            StateSetter setState) {
                                      setState = setState;
                                      return SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            for (int i = 1;
                                                i < stringData.length;
                                                ++i)
                                              RadioListTile(
                                                value: i,
                                                groupValue: index,
                                                selected: true,
                                                title: Text(
                                                  stringData[i],
                                                  style: TextStyle(
                                                      color: Colors.grey[800]),
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
                                      FlatButton(
                                        onPressed: () => Navigator.of(context,
                                                rootNavigator: true)
                                            .pop(),
                                        child: Text(
                                          'CANCEL',
                                          style:
                                              TextStyle(color: Colors.red[300]),
                                        ),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();

                                          setState(() {
                                            artType = stringData[index];
                                          });
                                        },
                                        child: Text('SUBMIT'),
                                        style: OutlinedButton.styleFrom(
                                            elevation: 0,
                                            primary: Colors.red[300]),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Text(artType)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text('SUBMIT'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
