import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:i_did/utils/fab.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Your tasks done this week'.toUpperCase(),
                  style: GoogleFonts.bebasNeue(
                      fontSize: 48.0,
                      color: Colors.grey[700],
                      backgroundColor: Colors.amber[100]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ClayContainer(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: Wrap(
                      spacing: 24,
                      alignment: WrapAlignment.spaceBetween,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          '50%',
                          style: GoogleFonts.bebasNeue(
                            fontSize: 24.0,
                            color: Colors.grey[700],
                          ),
                        ),
                        Container(
                          width: 2,
                          child: Divider(
                            thickness: 10,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          '40%',
                          style: GoogleFonts.bebasNeue(
                            fontSize: 24.0,
                            color: Colors.grey[700],
                          ),
                        ),
                        Container(
                          width: 2,
                          child: Divider(
                            thickness: 10,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          '80%',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 24.0, top: 16.0, bottom: 4.0),
                child: Text(
                  "Today's",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CardList(),
              ),
            ],
          ),
        ),
        floatingActionButton: FancyFab());
  }
}

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      //width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Here is my task',
              style: TextStyle(
                  fontSize: 28.0,
                  color: Colors.grey[700],
                  backgroundColor: Colors.green[50]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '15th March 2021',
                style: TextStyle(color: Colors.grey[700], fontSize: 18.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                'Description',
                style: TextStyle(color: Colors.grey[700], fontSize: 14.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
