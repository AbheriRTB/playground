import 'package:flutter/material.dart';
import 'package:sunaad/utils/drawer.dart';

class DictionaryArtistePage extends StatefulWidget {
  @override
  _DictionaryArtistePageState createState() => _DictionaryArtistePageState();
}

class _DictionaryArtistePageState extends State<DictionaryArtistePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Artists",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: MyDrawer(
        pos: 7,
      ),
      body: Container(
        child: Center(child: Text("Artists")),
      ),
    );
  }
}
