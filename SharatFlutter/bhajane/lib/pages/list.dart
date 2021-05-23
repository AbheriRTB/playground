import 'package:bhajane/models/bhajane.dart';
import 'package:bhajane/models/shloka.dart';
import 'package:bhajane/pages/lyrics.dart';
import 'package:flutter/material.dart';

class BhajaneListPage extends StatefulWidget {
  @override
  _BhajaneListPageState createState() => _BhajaneListPageState();
}

class _BhajaneListPageState extends State<BhajaneListPage> {
  List<Bhajane> bhajans = [
    Bhajane('Ganesha Sharanam', 'bhajane_1.txt', kannada: 'ಗಣೇಶ  ಶರಣಂ'),
    Bhajane('Mudakaratta Modakam', 'bhajane_2.txt',
        kannada: 'ಮುದಾಕರಾತ್ತ ಮೋದಕಂ'),
    Bhajane('Shuddhabhrma', 'bhajane_4.txt', kannada: 'ಶುದ್ಧಬ್ರಹ್ಮಪರಾತ್ಪರ'),
    Bhajane('Kodhanda Rama', 'bhajane_5.txt', kannada: 'ಕೋದಂಡರಾಂ'),
    Bhajane('Bhaja Govindam', 'bhajane_6.txt', kannada: 'ಭಜ ಗೋವಿಂದಂ'),
    Bhajane('Anjaneya Hanumanta', 'bhajane_8.txt', kannada: 'ಆಂಜನೇಯ ಹನುಮಂತ'),
    Bhajane('Veera Maruthi', 'bhajane_9.txt', kannada: 'ವೀರ  ಮಾರುತೀ'),
    Bhajane('Lingashtakam', 'bhajane_10.txt', kannada: 'ಬ್ರಹ್ಮಮುರಾರಿ'),
    Bhajane('Namasmarane', 'bhajane_11.txt', kannada: 'ನಾಮಸ್ಮರಣೋ'),
    Bhajane('Ambiga', 'bhajane_12.txt', kannada: 'ಅಂಬಿಗ'),
    Bhajane('Ramadutha Hanumanta', 'bhajane_13.txt', kannada: 'ರಾಮದೂತ ಹನುಮಂತ'),
    Bhajane('Prema mudita', 'bhajane_15.txt', kannada: 'ಪ್ರೇಮ ಮುದಿತ'),
    Bhajane('Kapikulesha', 'bhajane_16.txt', kannada: 'ಕಪಿಕುಲೇಶ'),
    Bhajane('Dasharathe', 'bhajane_17.txt', kannada: 'ದಾಶರಥೆ'),
    Bhajane('Ramalali', 'bhajane_19.txt', kannada: 'ರಾಮಲಾಲಿ'),
    Bhajane('Om mangalam', 'bhajane_21.txt', kannada: 'ಓಂ  ಮಂಗಳಂ'),
  ];
  @override
  Widget build(BuildContext context) {
    Color color = Color.fromRGBO(145, 47, 0, 0.8);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text('Contents - ವಿಷಯಸೂಚಿ'),
        centerTitle: false,
      ),
      body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: ListView.builder(
            itemCount: bhajans.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                        bhajans[index].name + ' - ' + bhajans[index].kannada),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BhjaneLyricsPage(bhajans, index)),
                      );
                    },
                  ),
                  Divider(
                    height: 0,
                  ),
                ],
              );
            },
          )),
    );
  }
}

class ShlokaListPage extends StatefulWidget {
  @override
  _ShlokaListPageState createState() => _ShlokaListPageState();
}

class _ShlokaListPageState extends State<ShlokaListPage> {
  List<Shloka> shlokas = [
    Shloka('Yakundendu', 'shloka-1.txt', kannada: 'ಯಾ ಕುನ್ದೆನ್ದು'),
    Shloka('Mahalakshmi Ashtakam', 'shloka-2.txt', kannada: 'ಮಹಾಲಕ್ಷ್ಮ್ಯಷ್ಟಕಮ'),
    Shloka('Annapoornaashtakam', 'shloka-3.txt',
        kannada: 'ಶ್ರೀ ಅನ್ನಪೂರ್ಣಾ ಸ್ತೋತ್ರಂ'),
    Shloka('Aikya mantra', 'shloka-4.txt', kannada: 'ಯಂ ವೈದಿಕಾ ಮನ್ತ್ರ'),
    Shloka('Manasa Satatam', 'shloka-5.txt', kannada: 'ಮನಸಾ ಸತತಂ'),
    //Shloka('Nitya prarthane', 'shloka-6.txt', kannada: ''),
  ];
  @override
  Widget build(BuildContext context) {
    Color color = Color.fromRGBO(145, 47, 0, 0.8);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text(
          'Contents - ವಿಷಯಸೂಚಿ',
        ),
        centerTitle: false,
      ),
      body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: ListView.builder(
            itemCount: shlokas.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                        shlokas[index].name + ' - ' + shlokas[index].kannada),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ShlokaLyricsPage(shlokas, index)),
                      );
                    },
                  ),
                  Divider(
                    height: 0,
                  ),
                ],
              );
            },
          )),
    );
  }
}
