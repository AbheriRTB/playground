import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sunaad/models/orgs.dart';
import 'package:sunaad/models/programs.dart';
import 'package:flutter/material.dart';
import 'package:sunaad/data/jason_data.dart';
import 'package:sunaad/data/data_utils.dart';
import 'package:sunaad/models/programs.dart';
import 'package:dart_date/dart_date.dart';

import '../models/orgs.dart';
import 'info.dart';

class DefaultList extends StatelessWidget {
  Programs progs;
  String imageUrl = 'https://abheri.pythonanywhere.com/static/images/';
  String defaultUrl =
      'https://abheri.pythonanywhere.com/static/images/default2.jpg';
  bool isFinished = false, isToday = false;

  DefaultList({
    @required this.progs,
    this.defaultUrl,
  });

  @override
  Widget build(BuildContext context) {
    isFinished = false;
    isToday = false;
    if (progs.event_date.isBefore(DateTime.now())) {
      isFinished = true;
      isToday = false;
    }
    if (progs.event_date.isSameDay(DateTime.now())) {
      isFinished = true;
      isToday = true;
    }

    if (progs.artiste_image.isNotEmpty) {
      defaultUrl = imageUrl + progs.artiste_image;
    } else {
      defaultUrl =
          'https://abheri.pythonanywhere.com/static/images/default2.jpg';
    }

    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(progs.event_date);

    TextStyle textStyle(double size) => TextStyle(
        fontSize: size,
        color: isToday ? Colors.orange[600] : Colors.grey[600],
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              color: isFinished ? Colors.purple[50] : Colors.transparent,
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        minRadius: 24,
                        backgroundColor: Colors.orangeAccent,
                        backgroundImage: NetworkImage('${defaultUrl}'),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 0.0, 15.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: (375.0 - 125),
                              child: Text(
                                progs.title,
                                style: textStyle(18),
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            SizedBox(
                              width: (375.0 - 125),
                              child: Text(
                                progs.description,
                                style: textStyle(14),
                                softWrap: true,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              ('On $formattedDate'),
                              style: textStyle(16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InfoPage(
                                programInfo: progs,
                              )));
                },
              ),
            ),
          ),
          Divider(
            height: 4.0,
          )
        ],
      ),
    );
  }
}
