import 'package:flutter/material.dart';
import 'package:kaksha/pages/page_about.dart';
import 'package:kaksha/pages/page_dictionary.dart';
import 'package:kaksha/pages/page_subashita.dart';
import 'package:kaksha/pages/page_topics.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Color background2 = Color.fromRGBO(233, 229, 205, 1);
  Color accent = Color.fromRGBO(218, 117, 68, 1);

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showPage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: background2,
        selectedItemColor: accent,
        unselectedItemColor: accent.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 12,
        currentIndex: _selectedIndex,
        onTap: (value) => _onItemTapped(value),
        items: [
          BottomNavigationBarItem(
            title: Text('Quotes'),
            icon: Icon(Icons.format_quote_rounded),
          ),
          BottomNavigationBarItem(
            title: Text('Topics'),
            icon: Icon(Icons.topic),
          ),
          BottomNavigationBarItem(
            title: Text('Dictionary'),
            icon: Icon(Icons.menu_book),
          ),
          BottomNavigationBarItem(
            title: Text('About'),
            icon: Icon(Icons.people),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  showPage() {
    switch (_selectedIndex) {
      case 0:
        return SubashitaPage();
      case 1:
        return TopicsPage();
      case 2:
        return DictionaryPage();
      case 3:
        return AboutPage();
    }
  }
}
