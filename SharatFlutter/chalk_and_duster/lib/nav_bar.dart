import 'package:chalk_and_duster/pages/home/page_classes.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Color primary = Color(0xff303242);
  Color secondary = Color(0xff394359);
  Color accentDark = Color(0xffE0C097);
  Color accent = Color(0xffB85C38);

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showPage(),
      backgroundColor: primary,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: secondary,
        selectedItemColor: accentDark,
        unselectedItemColor: accentDark.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 12,
        currentIndex: _selectedIndex,
        onTap: (value) => _onItemTapped(value),
        items: [
          BottomNavigationBarItem(
            label: 'Classes',
            icon: Icon(Icons.meeting_room),
          ),
          BottomNavigationBarItem(
            label: 'Direct',
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: 'Works',
            icon: Icon(Icons.work),
          ),
          BottomNavigationBarItem(
            label: 'Sheduled',
            icon: Icon(Icons.videocam),
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
        return ClassesPage();
      case 1:
      //return TopicsPage();
      case 2:
      // return DictionaryPage();
      case 3:
      //return AboutPage();
    }
  }
}
