import 'package:jotted/pages/home/classes/page_classes.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  NavBar({
    Key? key,
  }) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    //UsersData usersData = Provider.of<UsersData>(context);

    return Scaffold(
      body: showPage(),
      /* //backgroundColor: primary,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.green.withOpacity(.60),
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
            icon: Icon(Icons.groups),
          ),
          /*BottomNavigationBarItem(
            label: 'Works',
            icon: Icon(Icons.work),
          ),
          BottomNavigationBarItem(
            label: 'Sheduled',
            icon: Icon(Icons.videocam),
          ),*/
        ],
      ),*/
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
