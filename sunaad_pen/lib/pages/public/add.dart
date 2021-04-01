import 'package:flutter/material.dart';
import 'package:sunaad_pen/utils/text_input_signin.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "ADD",
                  style: TextStyle(
                    fontSize: 34,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                    backgroundColor: Colors.lime[200],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                decoration: textInputDecoration('Name'),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                decoration: textInputDecoration('Singer'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Title'),
                        contentPadding: EdgeInsets.zero,
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (int i = 1; i <= 100; i++)
                                ListTile(
                                  title: Text('option $i',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                  leading: Radio(
                                    value: i,
                                    groupValue: 1,
                                    onChanged: (_) {},
                                  ),
                                ),
                            ],
                          ),
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('ACTION 1'),
                          ),
                          FlatButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('ACTION 2'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
