import 'package:flutter/material.dart';
import 'package:join/assets/widget/list_widget.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                      child: Text(
                        'Jio Meet',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
                new Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 16.0, 0),
                  child: Column(
                    children: [
                      Text(
                        '1',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                      Text(
                        'FEB',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              indent: 16,
              endIndent: 16,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        // Menu
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.list_alt,
                color: Colors.white,
              ),
            ),
          ],
        ),

        // Anchor
        shape: CircularNotchedRectangle(),
      ),

      // Fab
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Container(
                  color: Color(0xFF737373),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        child: Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: Container(
                              color: Colors.amber,
                            )),
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(10),
                            topRight: const Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
