import 'package:bhajane/helpers/data.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Data> listData = [
    Data(1, "ಗಣೇಶ ಶರಣಂ", "Ganesha Sharanam", "page1.txt"),
    Data(2, "ಮುದಕರಾತ್ತ ಮೋದಕಂ", "Mudakaratta Modakam", "page2.txt"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Bhajane"),
        leading: Icon(Icons.music_note),
        centerTitle: false,
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              })
        ],
      ),
      body: ListView.builder(
          itemCount: listData.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange[300],
                    child: Icon(
                      Icons.book,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(listData[index].name),
                  subtitle: Text(listData[index].discription),
                  onTap: () {
                    Navigator.pushNamed(context, '/bhajane', arguments: {
                      'index': listData[index].index,
                      'name': listData[index].name,
                      'txt': listData[index].txt,
                    });
                  },
                ),
                Divider(
                  height: 0,
                  indent: 14,
                  endIndent: 14,
                )
              ],
            );
          }),
    );
  }
}
