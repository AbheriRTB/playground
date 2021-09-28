import 'package:chalk_and_duster/models/model_user.dart';
import 'package:chalk_and_duster/pages/home/page_add_group_details.dart';
import 'package:chalk_and_duster/services/database.dart';
import 'package:chalk_and_duster/widgets/widget_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class AddGroupPage extends StatefulWidget {
  @override
  _AddGroupPageState createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  Color primary = Color(0xff303242);

  Color secondary = Color(0xff394359);

  Color accentDark = Color(0xffE0C097);

  Color accent = Color(0xffB85C38);

  TextEditingController _searchController = TextEditingController();

  Future? resultsLoaded;
  List _allResults = [];
  List _resultsList = [];
  List _selectedList = [];

  String desc = '';

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users?>(context);
    return StreamBuilder<UsersData>(
        stream: DatabaseService(uid: users!.uid).userData,
        builder: (context, snapshot) {
          resultsLoaded = getUsers(snapshot.data!.orgId!);

          return Scaffold(
            backgroundColor: primary,
            appBar: AppBar(
              //backgroundColor: secondary,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: accent,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 0.0),
                    child: TextField(
                      controller: _searchController,
                      // onChanged: _onSearchChanged(),
                      decoration: textInputDecoration("Search"),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),*/
                  _selectedList.length > 0
                      ? Expanded(
                          flex: 2,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _selectedList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 28.0,
                                      backgroundColor: accent,
                                      child: Text(
                                        _selectedList[index]['displayName'][0]
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: accentDark,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _selectedList.removeAt(index);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor:
                                            accentDark.withOpacity(0.8),
                                        maxRadius: 10,
                                        child: Icon(
                                          Icons.close,
                                          size: 12,
                                          color: secondary,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Select Users',
                            style: TextStyle(color: accentDark, fontSize: 18.0),
                          ),
                        ),
                  Divider(
                    color: Colors.grey[600],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Expanded(
                    flex: 15,
                    child: ListView.builder(
                        itemCount: _resultsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (_resultsList[index]['isAdmin'] &&
                              _resultsList[index]['isTeacher']) {
                            desc = 'Admin & Teacher';
                          } else if (_resultsList[index]['isAdmin']) {
                            desc = 'Admin';
                          } else if (_resultsList[index]['isTeacher']) {
                            desc = 'Teacher';
                          } else {
                            desc = 'Student';
                          }
                          return CustomList.listTypeTwo(
                            onTap: () {
                              bool contains = false;
                              for (int i = 0; i < _selectedList.length; ++i) {
                                if (_selectedList[i]['uid'] ==
                                    _resultsList[index]['uid']) {
                                  contains = true;
                                  break;
                                }
                              }
                              if (!contains)
                                _selectedList.add(_resultsList[index]);
                            },
                            name: _resultsList[index]['displayName'],
                            desc: desc,
                          );
                        }),
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              icon: Icon(
                Icons.arrow_forward,
                size: 20,
                color: accentDark,
              ),
              label: Text(
                'Next',
                style: TextStyle(color: accentDark),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddGroupDetails(_selectedList),
                  ),
                );
              },
              backgroundColor: secondary,
            ),
          );
        });
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      for (var userSnapshot in _allResults) {
        var title =
            UsersData.fromDocument(userSnapshot).displayName!.toLowerCase();

        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(userSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  getUsers(String orgID) async {
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('orgId', isEqualTo: orgID)
        .get();

    setState(() {
      _allResults = result.docs;
    });
    searchResultsList();

    return 'complete';
  }
}
