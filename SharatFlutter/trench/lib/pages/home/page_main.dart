import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trench/models/model_cluster.dart';
import 'package:trench/services/auth.dart';
import 'package:trench/services/database.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Color scaffoldColor = Color(0xff1B1A1D);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Cluster>.value(
        initialData: Cluster.initialData(),
        value: DatabaseService().clusterData,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: scaffoldColor,
              elevation: 2,
              title: InkWell(
                onTap: () {
                  openDialog(context);
                },
                child: Text(
                  '#Main',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                splashColor: Colors.black45,
                highlightColor: Colors.black45,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey[600],
                    size: 26.0,
                  ),
                  splashColor: Colors.black45,
                  highlightColor: Colors.black45,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.grey[600],
                    size: 26.0,
                  ),
                  splashColor: Colors.black45,
                  highlightColor: Colors.black45,
                ),
              ],
            ),
            body: SafeArea(
                child: Column(
              children: [
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Send Message',
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.send,
                          color: Colors.amber[700]!.withOpacity(0.5),
                        ),
                        splashColor: Colors.black45,
                        highlightColor: Colors.black45,
                      ),
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.emoji_emotions_rounded,
                          color: Colors.grey[600],
                        ),
                        splashColor: Colors.black45,
                        highlightColor: Colors.black45,
                      ),
                    ),
                    cursorColor: Colors.amber,
                    cursorWidth: 3,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 15,
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            )),
          );
        });
  }

  openDialog(contextThat) {
    showDialog(
      context: contextThat,
      builder: (context) {
        return AlertDialog(
          content: FolderNav(),
          backgroundColor: scaffoldColor,
        );
      },
    );
  }

  Widget FolderNav() {
    return Container(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                'Channels',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey[800],
            height: 20,
            thickness: 4,
          ),
          SizedBox(
            height: 8.0,
          ),
          Column(
            children: [
              Text(
                'Threads',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
