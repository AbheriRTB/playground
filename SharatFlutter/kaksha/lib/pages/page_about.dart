import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
                'About',
                style: TextStyle(
                  fontSize: 36.0,
                  color: Colors.cyan[700],
                ),
              ),
              Text(
                'विवरणम',
                style: TextStyle(
                  fontSize: 28.0,
                  color: Colors.cyan[700],
                  fontFamily: 'Hind',
                ),
              ),
              SizedBox(
                height: 34.0,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: background,
    );
  }
}
