import 'package:bhajane/pages/list.dart';
import 'package:flutter/material.dart';

class SelectPage extends StatefulWidget {
  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  @override
  Widget build(BuildContext context) {
    Color color = Color.fromRGBO(145, 47, 0, 0.8);
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.lime[700],
      //   title: Text('Home'),
      //   centerTitle: false,
      // ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/lord-rama.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.white.withOpacity(0.1),
          child: Center(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BhajaneListPage()));
                      },
                      child: Text(
                        'Bhajane',
                        style: TextStyle(fontSize: 24, color: Colors.grey[400]),
                      ),
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(BorderSide(
                            color: Colors.amber[600].withOpacity(0.3),
                            width: 3)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          //Colors.amber.withOpacity(0.3),
                          color,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShlokaListPage()));
                      },
                      child: Text(
                        'Shlokas',
                        style: TextStyle(fontSize: 24, color: Colors.grey[400]),
                      ),
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(BorderSide(
                            color: Colors.amber.withOpacity(0.3), width: 3)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          color,
                        ),
                      ),
                    ),
                  ),
                  //),
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   child: Text(
                  //     'Vamsha Vruksha',
                  //     style: TextStyle(fontSize: 24, color: Colors.white),
                  //   ),
                  //   style: ButtonStyle(
                  //     backgroundColor: MaterialStateProperty.all<Color>(
                  //         Colors.green.withOpacity(0.0)),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
