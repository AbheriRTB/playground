import 'package:chalk_board/models/posts.dart';
import 'package:chalk_board/models/user.dart';
import 'package:chalk_board/pages/public/new.dart';
import 'package:chalk_board/services/auth.dart';
import 'package:chalk_board/services/database.dart';
import 'package:chalk_board/utils/card.dart';
import 'package:chalk_board/utils/menu.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot> searchResultsFuture;
  Future<QuerySnapshot> postResultsFuture;
  String uid;

  String postID;

  handleSearch(String query) {
    final CollectionReference usersCollection = FirebaseFirestore.instance
        .collection('posts')
        .doc(uid)
        .collection('userPosts');

    Future<QuerySnapshot> users =
        usersCollection.where('dishName', isEqualTo: query).get();
    setState(() {
      searchResultsFuture = users;
    });
  }

  getPosts() async {
    uid = await AuthService().getUID();
    final CollectionReference postCollection = FirebaseFirestore.instance
        .collection('posts')
        .doc(uid)
        .collection('userPosts');
    print(postCollection);
    Future<QuerySnapshot> posts = postCollection.get();
    QuerySnapshot posts2 = await postCollection.get();

    posts2.docs.forEach((element) {
      setState(() {
        postID = element.id;
      });
    });
    setState(() {
      postResultsFuture = posts;
    });
  }

  final isSelected = <bool>[false, false, false];
  double opacity = 0.1;
  List<String> searchResultsStr = [];

  buildSearchResults() {
    return FutureBuilder(
      future: searchResultsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        List<CardList> searchResults = [];
        snapshot.data.docs.forEach((doc) {
          Posts user = Posts.fromDocument(doc);
          searchResults.add(CardList(post: user));
        });

        return ListView(
          children: searchResults,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
        );
        //return null;
      },
    );
  }

  buildPostResults() {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: postResultsFuture,
        builder: (context, snapshot) {
          Posts post;
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          List<CardList> postResults = [];
          snapshot.data.docs.forEach(
            (doc) {
              post = Posts.fromDocument(doc);
              postResults.add(CardList(post: post));
            },
          );
          return ListView(
            children: postResults,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var inputDecoration = InputDecoration(
        border: InputBorder.none,
        labelText: 'Search',
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: TextStyle(
          fontFamily: GoogleFonts.indieFlower().fontFamily,
          color: Colors.grey[700],
          fontSize: 16.0,
        ),
        filled: true,
        fillColor: Colors.grey[800].withOpacity(opacity),
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: Icon(
          Icons.search,
          //color: Colors.grey[600],
        ),
        suffixIcon: MenuPopup());

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: TextFormField(
                    controller: searchController,
                    autofocus: false,
                    style: TextStyle(fontSize: 15.0, color: Colors.lime[800]),
                    decoration: inputDecoration,
                    cursorColor: Colors.grey,
                    onFieldSubmitted: handleSearch),
              ),
              Container(
                child: searchResultsFuture == null
                    ? Text('')
                    : buildSearchResults(),
              ),
              //ListView.builder(itemCount: 8, itemBuilder: (context, index) {}),
              postResultsFuture == null
                  ? Text('Hello1')
                  : searchResultsFuture == null
                      ? buildPostResults()
                      : Text(''),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return NewPage();
                },
              ),
            );
            //AuthService().signOut();
          },
          child: Icon(
            Icons.receipt_long_sharp,
            color: Colors.grey[800],
          ),
          backgroundColor: Colors.amber.withOpacity(0.7),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
