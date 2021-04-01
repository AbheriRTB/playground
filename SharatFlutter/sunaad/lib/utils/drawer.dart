import 'package:flutter/material.dart';
import 'package:sunaad/pages/Dictionary/dictionary_artiste.dart';
import 'package:sunaad/pages/Dictionary/dictionary_organizer.dart';
import 'package:sunaad/pages/Dictionary/dictionary_venue.dart';
import 'package:sunaad/pages/banner.dart';
import 'package:sunaad/pages/events/event_city.dart';
import 'package:sunaad/pages/events/event_date.dart';
import 'package:sunaad/pages/events/event_artiste.dart';
import 'package:sunaad/pages/events/event_organizer.dart';
import 'package:sunaad/pages/events/event_type.dart';
import 'package:sunaad/pages/events/event_venue.dart';

class MyDrawer extends StatefulWidget {
  int pos;
  MyDrawer({this.pos});
  @override
  _MyDrawerState createState() => _MyDrawerState(pos);
}

class _MyDrawerState extends State<MyDrawer> {
  int _selectedDestination = 10;
  _MyDrawerState(this._selectedDestination);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 52.0, 16.0, 0.0),
                child: Text(
                  "SUNAAD",
                  style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 0.0, 16.0, 16.0),
                child: Text("abheriteam@gmail.com",
                    style: TextStyle(
                        fontSize: 14,
                        //fontWeight: FontWeight.bold,
                        color: Colors.grey[600])),
              ),
            ],
          ),
          Divider(
            height: 1,
            thickness: 1,
            endIndent: 32,
            indent: 16,
          ),
          ListTile(
              leading: Icon(Icons.home_rounded),
              title: Text(
                'Home',
                style: textStyleDefault(),
              ),
              selected: _selectedDestination == 0,
              onTap: () {
                if (_selectedDestination == 0) {
                  Navigator.pop(context);
                } else {
                  selectDestination(0);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BannerPage()),
                  );
                }
              }),
          Divider(
            height: 1,
            thickness: 1,
            endIndent: 32,
            indent: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Sort Events By',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          ListTile(
              leading: Icon(Icons.timer),
              title: Text(
                'Date',
                style: textStyleDefault(),
              ),
              selected: _selectedDestination == 1,
              onTap: () {
                if (_selectedDestination == 1) {
                  Navigator.pop(context);
                } else {
                  selectDestination(1);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => EventDatePage()),
                  );
                }
              }),
          ListTile(
            leading: Icon(Icons.people),
            title: Text(
              'Artiste',
              style: textStyleDefault(),
            ),
            selected: _selectedDestination == 2,
            onTap: () {
              if (_selectedDestination == 2) {
                Navigator.pop(context);
              } else {
                selectDestination(2);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => EventArtistePage()),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.location_pin),
            title: Text(
              'Venue',
              style: textStyleDefault(),
            ),
            selected: _selectedDestination == 3,
            onTap: () {
              if (_selectedDestination == 3) {
                Navigator.pop(context);
              } else {
                selectDestination(3);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => EventVenuePage()),
                );
              }
            },
          ),
          ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text(
                'Organizer',
                style: textStyleDefault(),
              ),
              selected: _selectedDestination == 4,
              onTap: () {
                if (_selectedDestination == 4) {
                  Navigator.pop(context);
                } else {
                  selectDestination(4);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventOrganizerPage()),
                  );
                }
              }),
          ListTile(
            leading: Icon(Icons.music_note),
            title: Text(
              'Event Type',
              style: textStyleDefault(),
            ),
            selected: _selectedDestination == 5,
            onTap: () {
              if (_selectedDestination == 5) {
                Navigator.pop(context);
              } else {
                selectDestination(5);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => EventTypePage()),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.location_city_rounded),
            title: Text(
              'City',
              style: textStyleDefault(),
            ),
            selected: _selectedDestination == 6,
            onTap: () {
              if (_selectedDestination == 6) {
                Navigator.pop(context);
              } else {
                selectDestination(6);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => EventCityPage()),
                );
              }
            },
          ),
          Divider(
            height: 1,
            thickness: 1,
            endIndent: 32,
            indent: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Dictatonary',
              style: textStyleDefault(),
            ),
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text(
              'Artiste',
              style: textStyleDefault(),
            ),
            selected: _selectedDestination == 7,
            onTap: () {
              if (_selectedDestination == 7) {
                Navigator.pop(context);
              } else {
                selectDestination(7);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DictionaryArtistePage()),
                );
              }
            },
          ),
          ListTile(
              leading: Icon(Icons.location_pin),
              title: Text(
                'Venue',
                style: textStyleDefault(),
              ),
              selected: _selectedDestination == 8,
              onTap: () {
                if (_selectedDestination == 8) {
                  Navigator.pop(context);
                } else {
                  selectDestination(8);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DictionaryVenuePage()),
                  );
                }
              }),
          ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text(
                'Organizer',
                style: textStyleDefault(),
              ),
              selected: _selectedDestination == 9,
              onTap: () {
                if (_selectedDestination == 9) {
                  Navigator.pop(context);
                } else {
                  selectDestination(9);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DictionaryOrganizerPage()),
                  );
                }
              }),
        ],
      ),
    );
  }

  TextStyle textStyleDefault() {
    return TextStyle();
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}
