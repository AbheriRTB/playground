import 'package:flutter/material.dart';
import 'package:kaksha/models/model_explain.dart';
import 'package:kaksha/models/model_topics.dart';
import 'package:kaksha/pages/page_topics_explain.dart';
import 'package:kaksha/widgets/list_tile.dart';

class TopicsPage extends StatefulWidget {
  const TopicsPage({Key? key}) : super(key: key);

  @override
  _TopicsPageState createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  Color background = Color.fromRGBO(253, 246, 227, 1);
  Color background2 = Color.fromRGBO(233, 229, 205, 1);
  Color accent = Color.fromRGBO(218, 117, 68, 1);

  List<Topics> topics = [
    Topics(name: 'Meeting With Friends', explanation: [
      Explain(
          engName: 'engName1',
          sanTrans: 'sanTrans1',
          engTrans: 'engTrans1',
          isSelected: false),
      Explain(
          engName: 'engName2',
          sanTrans: 'sanTrans2',
          engTrans: 'engTrans2',
          isSelected: false),
      Explain(
          engName: 'engName2',
          sanTrans: 'sanTrans2',
          engTrans: 'engTrans2',
          isSelected: false),
      Explain(
          engName: 'engName2',
          sanTrans: 'sanTrans2',
          engTrans: 'engTrans2',
          isSelected: false),
      Explain(
          engName: 'engName2',
          sanTrans: 'sanTrans2',
          engTrans: 'engTrans2',
          isSelected: false),
      Explain(
          engName: 'engName2',
          sanTrans: 'sanTrans2',
          engTrans: 'engTrans2',
          isSelected: false),
      Explain(
          engName: 'engName2',
          sanTrans: 'sanTrans2',
          engTrans: 'engTrans2',
          isSelected: false),
      Explain(
          engName: 'engName2',
          sanTrans: 'sanTrans2',
          engTrans: 'engTrans2',
          isSelected: false),
    ]),
    Topics(name: 'Meeting With Friends', explanation: [
      Explain(
          engName: 'engName1',
          sanTrans: 'sanTrans1',
          engTrans: 'engTrans1',
          isSelected: false),
      Explain(
          engName: 'engName2',
          sanTrans: 'sanTrans2',
          engTrans: 'engTrans2',
          isSelected: false),
    ]),
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
              Text(
                'Topics',
                style: TextStyle(
                  fontSize: 36.0,
                  color: Colors.cyan[700],
                ),
              ),
              Text(
                'विषय',
                style: TextStyle(
                  fontSize: 28.0,
                  color: Colors.cyan[700],
                  fontFamily: 'Hind',
                ),
              ),
              SizedBox(
                height: 34.0,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: topics.length,
                    itemBuilder: (context, index) {
                      return CustomList.listTypeThree(
                        topics: topics[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExplanationPage(
                                list: topics[index].explanation,
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: background,
    );
  }
}
