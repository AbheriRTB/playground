import 'package:flutter/material.dart';
import 'package:protrack/services/auth.dart';
import 'package:protrack/services/database.dart';
import 'package:protrack/utils/example.dart';

class AddGoalPage extends StatefulWidget {
  @override
  _AddGoalPageState createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add",
                style: TextStyle(fontSize: 56, color: Colors.grey[600]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Goal Name",
                    icon: Icon(Icons.flag),
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Description",
                  icon: Icon(Icons.description),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime(2020, 11, 17),
                        firstDate: DateTime(2017, 1),
                        lastDate: DateTime(2022, 7),
                        helpText: 'Select a date',
                      );
                    },
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(
                          Icons.timer,
                          size: 22,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("End Date"),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      primary: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // AppBar
      bottomNavigationBar: new BottomAppBar(
        color: Colors.lime,

        // Menu
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        // Anchor
        //shape: CircularNotchedRectangle(),
      ),

      // Fab
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Example(),
                fullscreenDialog: true,
              ));
        },
        icon: Icon(Icons.add),
        label: Text("CREATE GOAL"),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
