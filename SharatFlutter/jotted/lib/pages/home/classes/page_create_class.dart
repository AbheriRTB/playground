import 'package:jotted/models/model_group.dart';
import 'package:jotted/models/model_user.dart';
import 'package:jotted/services/database.dart';
import 'package:jotted/widgets/widget_list.dart';
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

  String? message;

  List<String> uploadList = [];

  final _formKey = GlobalKey<FormState>();

  TextEditingController _searchController = TextEditingController();
  TextEditingController controller = TextEditingController();

  Future? resultsLoaded;
  List _allResults = [];
  List _resultsList = [];
  List _selectedList = [];

  String desc = '';

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users?>(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return StreamBuilder<UsersData>(
        stream: DatabaseService(uid: users!.uid).userData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          resultsLoaded = getUsers(snapshot.data!.orgId!);

          return Scaffold(
            appBar: AppBar(
              title: const Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Text(
                  'Select Users',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              centerTitle: false,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: controller,
                        validator: (val) =>
                            val!.isNotEmpty ? null : 'Enter Group Name',
                        onChanged: (val) {
                          setState(() => message = val.trim());
                        },

                        style: const TextStyle(fontSize: 18.0),
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.group,
                          ),
                          filled: false,
                          hintText: 'Group Name'.toUpperCase(),
                        ),
                        //keyboardType: TextInputType.phone,
                        autocorrect: true,
                      ),
                    ),
                    _selectedList.isNotEmpty
                        ? const Divider(thickness: 1)
                        : Container(),
                    _selectedList.isNotEmpty
                        ? Expanded(
                            flex: 2,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _selectedList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: Material(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: colorScheme.surface,
                                          child: InkWell(
                                            onTap: () {
                                              _selectedList.removeAt(index);
                                            },
                                            child: Center(
                                              child: Text(
                                                _selectedList[index]
                                                        ['displayName'][0]
                                                    .toString()
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 22.0,
                                                  color: colorScheme.onSurface,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(46),
                                            color: colorScheme.error
                                                .withOpacity(0.8),
                                            child: const Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: Icon(
                                                Icons.close,
                                                size: 12,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(),
                    const Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextField(
                        controller: _searchController,
                        onChanged: _onSearchChanged(),
                        style: const TextStyle(fontSize: 18.0),
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.search,
                            size: 22,
                          ),
                          filled: false,
                          hintText: 'Search Users'.toUpperCase(),
                          hintStyle: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        //keyboardType: TextInputType.phone,
                        autocorrect: true,
                      ),
                    ),
                    const SizedBox(
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
            ),
            floatingActionButton: FloatingActionButton.extended(
              icon: const Icon(
                Icons.add,
                size: 20,
              ),
              label: Text(
                'Create'.toUpperCase(),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  for (var element in _selectedList) {
                    uploadList.add(element['uid']);
                  }
                  await DatabaseService(
                    orgId: _selectedList[1]['orgId'],
                  ).updateGroupData(Groups(
                    grupName: message,
                    grupUsers: uploadList,
                  ));
                  Navigator.pop(context);
                }
              },
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
    //setState(() {
    _resultsList = showResults;
    //  });
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
