import 'package:bhajane/models/bhajane.dart';
import 'package:bhajane/pages/lyrics.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Bhajane> bhajans = [
    Bhajane('Mudakaratta Modakam', 'bhajane-1.txt',
        kannada: 'ಮುದಾಕರಾತ್ತ ಮೋದಕಂ'),
    Bhajane('Bhaja Govindam', 'bhajane-2.txt', kannada: 'ಭಜ ಗೋವಿಂದಂ'),
    Bhajane('Lingashtakam', 'bhajane-3.txt', kannada: 'Lingashtakam'),
    Bhajane('Ganesha Sharanam', 'bhajane-4.txt', kannada: 'ಗಣೇಶ  ಶರಣಂ'),
    Bhajane('Namasmarane', 'bhajane-5.txt', kannada: 'ನಾಮಸ್ಮರಣೋ'),
    Bhajane('Veera Maruthi', 'bhajane-6.txt', kannada: 'ವೀರ  ಮಾರುತೀ'),
    Bhajane('Kodhanda Rama', 'bhajane-7.txt', kannada: 'ಕೋದಂಡರಾಂ'),
    Bhajane('Prema mudita', 'bhajane-8.txt', kannada: 'ಪ್ರೇಮ ಮುದಿತ'),
    Bhajane('Ambiga', 'bhajane-9.txt', kannada: 'ಅಂಬಿಗ'),
    Bhajane('Shuddhabhrma', 'bhajane-10.txt', kannada: 'ಶುದ್ಧಬ್ರಹ್ಮಪರಾತ್ಪರ'),
    Bhajane('Ramalali', 'bhajane-11.txt', kannada: 'ರಾಮಲಾಲಿ'),
    Bhajane('Om mangalam', 'bhajane-12.txt', kannada: 'ಓಂ  ಮಂಗಳಂ'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[700],
      ),
      body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: ListView.builder(
            itemCount: bhajans.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(bhajans[index].name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LyricsPage(bhajans, index)),
                      );
                    },
                  ),
                  Divider(
                    height: 0,
                  )
                ],
              );
            },
          )),
    );
  }
}
