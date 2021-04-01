import 'package:flutter/material.dart';
import 'package:sunaad/data/jason_data.dart';
import 'package:sunaad/utils/drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sunaad/models/programs.dart';
import 'package:http/http.dart' as http;

class BannerPage extends StatefulWidget {
  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  CarouselSlider carouselSlider;
  bool loading = true;
  String imageUrl = 'https://abheri.pythonanywhere.com/static/images/';
  List imgList = [
    'https://images.unsplash.com/photo-1502117859338-fd9daa518a9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1554321586-92083ba0a115?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1536679545597-c2e5e1946495?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1543922596-b3bbaba80649?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1502943693086-33b5b1cfdf2f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80'
  ];

  List<Programs> progs;
  Set bannerSet = Set();
  List banners = List();

  List map(List list, Function handler) {
    List result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sunaad",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: MyDrawer(
        pos: 0,
      ),
      body: Center(
        child: FutureBuilder<List<Programs>>(
          future: JasonData().fetchPrograms(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              loading = false;
              for (int i = 0; i < snapshot.data.length; ++i) {
                String url = snapshot.data[i].splash_url;
                url = url.replaceAll('.html', '.jpg');
                print('Url: ' + url);
                if (snapshot.data[i].is_featured == 'Yes') {
                  bannerSet.add(imageUrl + url);
                  banners = bannerSet.toList();
                }
              }
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  carouselSlider = CarouselSlider(
                    options: CarouselOptions(
                      height: 640.0,
                      initialPage: 0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      reverse: false,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlayAnimationDuration: Duration(milliseconds: 2000),
                      pauseAutoPlayOnTouch: true,

                      //pauseAutoPlayOnTouch: Duration(seconds: 10),
                      scrollDirection: Axis.horizontal,
                      /* onPageChanged: (index) {
                                    setState(() {
                                      _current = index;
                                    });
                                  },*/
                    ),
                    items: banners.map((imgUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            //margin: EdgeInsets.symmetric(horizontal: 2.0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.network(
                                imgUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
