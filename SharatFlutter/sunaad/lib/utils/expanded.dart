import 'package:flutter/material.dart';
import 'package:sunaad/data/data_utils.dart';
import 'package:sunaad/data/jason_data.dart';
import 'package:sunaad/utils/list_tile.dart';
import 'package:sunaad/models/orgs.dart';
import 'package:sunaad/models/programs.dart';

import 'package:http/http.dart' as http;

class ExpandableListTile extends StatefulWidget {
  int index;
  bool imageThere;

  ExpandableListTile({@required this.index, @required this.imageThere});

  @override
  _ExpandableListTileState createState() => _ExpandableListTileState();
}

class _ExpandableListTileState extends State<ExpandableListTile> {
  List<Orgs> orgs;

  String imageUrl = 'https://abheri.pythonanywhere.com/static/images/';

  String defaultUrl =
      'https://abheri.pythonanywhere.com/static/images/default2.jpg';

  List<Programs> prgList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Programs>>(
          future: JasonData().fetchPrograms(http.Client()),
          builder: (context, snapshot) {
            List<String> artList;
            if (snapshot.hasData) prgList = snapshot.data;

            switch (widget.index) {
              case 0:
                artList = DataUtils().getArtisteListFromPrograms(prgList);
                orgs = DataUtils()
                    .createArtisteProgramCollection(prgList, artList);
                break;
              case 1:
                artList = DataUtils().getVenueListFromPrograms(prgList);
                orgs =
                    DataUtils().createVenueProgramCollection(prgList, artList);
                break;
              case 2:
                artList = DataUtils().getOrganizersListFromPrograms(prgList);
                orgs = DataUtils()
                    .createOrganizersProgramCollection(prgList, artList);
                break;
              case 3:
                artList = DataUtils().getEventTypeListFromPrograms(prgList);
                orgs = DataUtils()
                    .createEventTypeProgramCollection(prgList, artList);
                break;
              case 4:
                artList = DataUtils().getCityListFromPrograms(prgList);
                orgs =
                    DataUtils().createCityProgramCollection(prgList, artList);
                break;
            }
            if (snapshot.hasError) print(snapshot.error);
            return ListView.builder(
              itemCount: orgs.length,
              itemBuilder: (context, index) {
                if (orgs[index].artiste_image.isNotEmpty) {
                  defaultUrl = imageUrl + orgs[index].artiste_image;
                } else {
                  defaultUrl =
                      'https://abheri.pythonanywhere.com/static/images/default2.jpg';
                }

                return Column(
                  children: [
                    ExpansionTile(
                      leading: widget.imageThere
                          ? CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColor,
                              backgroundImage: NetworkImage(defaultUrl),
                            )
                          : null,
                      title: Text(
                        orgs[index].title,
                      ),
                      children: <Widget>[
                        Column(
                          children: _buildExpandableContent(
                              orgs[index], orgs[index].children),
                        ),
                      ],
                    ),
                    Divider(
                      indent: 8.0,
                      endIndent: 8.0,
                      height: 0.0,
                    ),
                  ],
                );
              },
            );
          }),
    );
  }

  _buildExpandableContent(Orgs orgs, List<Programs> progs) {
    List<Widget> columnContent = [];

    for (int i = 0; i < progs.length; ++i) {
      columnContent.add(DefaultList(
        progs: progs[i],
      ));
    }

    return columnContent;
  }
}
