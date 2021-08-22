import 'package:flutter/material.dart';

class SubashitaPage extends StatefulWidget {
  const SubashitaPage({Key? key}) : super(key: key);

  @override
  _SubashitaPageState createState() => _SubashitaPageState();
}

class _SubashitaPageState extends State<SubashitaPage> {
  Color background = Color.fromRGBO(253, 246, 227, 1);
  Color background2 = Color.fromRGBO(233, 229, 205, 1);
  Color accent = Color.fromRGBO(218, 117, 68, 1);

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
            Text(
              'Subhashita',
              style: TextStyle(
                fontSize: 36.0,
                color: Colors.cyan[700],
              ),
            ),
            Text(
              'सुभाषिता',
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.cyan[700],
                fontFamily: 'Hind',
              ),
            ),
            SizedBox(
              height: 34.0,
            ),
            Text(
              'यथा चित्तम् तथा वाचो यथा वाचस्तथा क्रिया: ।\nचित्तम् वाचि क्रियायाम् च साधुनामेकरूपता ॥',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey[700],
                fontFamily: 'Hind',
              ),
            ),
            SizedBox(
              height: 14.0,
            ),
            Text(
              "What is in mind should be reflected in one's speech (yatha chittam tatha vacho). What is in one's speech should be reflected in one's actions (yatha vachastatha kriya). Thus the person whose mind, speech and actions are same is a 'sadhu' (I don't think 'gentlemen' is a word anywhere close to the meaning of word 'sadhu'! Meanings of some words can be best appreciated in that language only.).",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      )),
      backgroundColor: background,
    );
  }
}
