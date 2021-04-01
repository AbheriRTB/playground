import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunaad_pen/data/jason_data.dart';
import 'package:sunaad_pen/models/user.dart';
import 'package:sunaad_pen/pages/auth/authenticate.dart';
import 'package:sunaad_pen/pages/page.dart';

import 'package:http/http.dart' as http;

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    void splash() async {
      await (JasonData().fetchPrograms(http.Client()));
      await (JasonData().fetchArtisteDir(http.Client()));
      await (JasonData().fetchVenueDir(http.Client()));
      await (JasonData().fetchOrganizerDir(http.Client()));
    }

    splash();
    final user = Provider.of<Users>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Pages233();
    }
  }
}
