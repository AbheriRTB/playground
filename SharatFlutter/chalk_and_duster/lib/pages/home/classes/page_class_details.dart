import 'package:chalk_and_duster/models/model_%20group.dart';
import 'package:flutter/material.dart';

class ClassDetailsPage extends StatefulWidget {
  const ClassDetailsPage({Key? key, required this.group}) : super(key: key);

  final Groups group;

  @override
  _ClassDetailsPageState createState() => _ClassDetailsPageState();
}

class _ClassDetailsPageState extends State<ClassDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.6,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            'Group Details',
            style: TextStyle(
              fontFamily: 'Integral',
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[600],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 16.0,
            ),
            Text(
              '${widget.group.grupName!}',
              style: TextStyle(
                fontFamily: 'Integral',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
