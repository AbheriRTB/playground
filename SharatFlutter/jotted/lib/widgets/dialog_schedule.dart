import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScheduleDialog extends StatefulWidget {
  const ScheduleDialog({Key? key}) : super(key: key);

  @override
  _ScheduleDialogState createState() => _ScheduleDialogState();
}

class _ScheduleDialogState extends State<ScheduleDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.grey[600],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Schedule Class',
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        elevation: 2,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'SAVE',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Class Name',
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Class Description',
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Class Link',
                ),
                maxLines: null,
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Container(
                      width: double.maxFinite,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          'Date',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Flexible(
                    child: Container(
                      width: double.maxFinite,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          'Time',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
