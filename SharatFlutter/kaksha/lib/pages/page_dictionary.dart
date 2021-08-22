import 'package:flutter/material.dart';
import 'package:kaksha/widgets/list_tile.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  Color background = Color.fromRGBO(253, 246, 227, 1);
  Color background2 = Color.fromRGBO(233, 229, 205, 1);
  Color accent = Color.fromRGBO(218, 117, 68, 1);

  List<String> words = [
    'Meeting With Friends - Meeting is the best place to meet and run',
    'Hello - A word used to greet'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                cursorColor: Theme.of(context).cursorColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: accent,
                  ),
                  labelText: 'Search',
                  labelStyle: TextStyle(
                    color: accent,
                    fontSize: 20,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: accent),
                  ),
                ),
              ),
              SizedBox(
                height: 36.0,
              ),
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: words.length,
                    itemBuilder: (context, index) {
                      return CustomList.listTypeTwo(words[index], onTap: () {});
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: background,
    );
  }
}
