import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jotted/models/model_files.dart';

import 'package:jotted/models/model_group.dart';
import 'package:jotted/models/model_message.dart';
import 'package:jotted/models/model_user.dart';
import 'package:jotted/pages/api/api_firebase.dart';
import 'package:jotted/pages/home/classes/page_class_details.dart';
import 'package:jotted/services/database.dart';
import 'package:jotted/widgets/widget_message.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GroupMessagesPage extends StatefulWidget {
  GroupMessagesPage({
    Key? key,
    required this.grups,
    required this.web,
  }) : super(key: key);

  Groups grups;
  bool web;

  @override
  _GroupMessagesPageState createState() => _GroupMessagesPageState();
}

class _GroupMessagesPageState extends State<GroupMessagesPage> {
  String? message;

  List? readUsersList;

  UploadTask? task;

  @override
  Widget build(BuildContext context) {
    UsersData userData = Provider.of<UsersData>(context);

    return StreamBuilder<List<Messages>>(
      stream: DatabaseService(
        grupId: widget.grups.grupId,
        orgId: userData.orgId,
      ).messagesData,
      builder: (context, snapshot) {
        List<Messages> data = snapshot.data!;

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        }
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottomOpacity: 0.8,
              backgroundColor: widget.web
                  ? Theme.of(context).colorScheme.primaryVariant
                  : Theme.of(context).appBarTheme.backgroundColor,
              bottom: TabBar(
                indicator: const UnderlineTabIndicator(
                  insets: EdgeInsets.symmetric(
                    horizontal: 36.0,
                  ),
                ),
                tabs: [
                  Tab(
                    child: Text(
                      'Chat'.toUpperCase(),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Files'.toUpperCase(),
                    ),
                  ),
                  /*Tab(
                    child: Text(
                      'Classes',
                      style: TextStyle(
                        color: Color(0xff90D44B).withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),*/
                  Tab(
                    child: Text(
                      'Tasks'.toUpperCase(),
                    ),
                  ),
                ],
              ),
              title: InkWell(
                splashColor: Theme.of(context)
                    .colorScheme
                    .primaryVariant
                    .withOpacity(0.1),
                highlightColor: Theme.of(context)
                    .colorScheme
                    .primaryVariant
                    .withOpacity(0.1),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClassDetailsPage(
                          group: widget.grups,
                        ),
                      ));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            widget.grups.grupName!.toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Icon(
                          Icons.arrow_right,
                        ),
                      ],
                    ),
                    Text(
                      '${widget.grups.grupUsers!.length} members',
                      style: const TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              centerTitle: false,
              leading: IconButton(
                icon: Icon(
                  widget.web ? Icons.group : Icons.arrow_back,
                ),
                disabledColor: Theme.of(context).colorScheme.background,
                onPressed: widget.web
                    ? null
                    : () {
                        Navigator.pop(context);
                      },
              ),
            ),
            body: TabBarView(
              children: [
                ChatsPageWidget(
                  web: widget.web,
                  data: data,
                  grups: widget.grups,
                  userData: userData,
                ),
                Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StreamBuilder<List<Files>>(
                        initialData: [],
                        stream: DatabaseService(
                                orgId: userData.orgId,
                                grupId: widget.grups.grupId)
                            .filesData,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          List<Files> files = snapshot.data!;

                          return ListView.builder(
                              itemCount: files.length,
                              itemBuilder: (context, index) {
                                return StreamBuilder<UsersData>(
                                    stream: DatabaseService(
                                            uid: files[index].uidFrom!)
                                        .userData,
                                    initialData: UsersData.initialData(),
                                    builder: (context, snapshot2) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                      UsersData usersData = snapshot2.data!;

                                      return Column(
                                        children: [
                                          FileCard(
                                            fileName: files[index].fileName!,
                                            userName: usersData.displayName!,
                                            onTap: () async {
                                              await canLaunch(
                                                      files[index].fileUrl!)
                                                  ? await launch(
                                                      files[index].fileUrl!)
                                                  : throw 'Could not launch ${files[index].fileUrl!}';
                                            },
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          )
                                        ],
                                      );
                                    });
                              });
                        }),
                  ),
                  floatingActionButton: userData.isAdmin!
                      ? FloatingActionButton(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              File file = File(result.files.single.path!);

                              showFileDialog(context, file, userData);
                            } else {
                              // User canceled the picker
                            }
                          },
                          child: const Icon(Icons.add),
                        )
                      : null,
                ),
                const Center(
                  child: Text(
                    'COMMING SOON',
                    style: TextStyle(
                        fontFamily: 'Integral', fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      initialData: const [],
    );
  }

  showFileDialog(BuildContext context, File file, UsersData userData) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    final fileName = basename(file.path);
    final destination =
        'media/${userData.orgId}/${widget.grups.grupId}/files/$fileName';

    showDialog(
      context: context,
      builder: (conxt) => AlertDialog(
        title: Center(
            child: Text(
          'UPLOAD FILE',
          style: TextStyle(
            overflow: TextOverflow.fade,
            fontFamily: GoogleFonts.lekton().fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 24.0,
            color: colorScheme.onSurface,
          ),
        )),
        content: FileCard(
          fileName: basenameWithoutExtension(file.path),
          userName: userData.displayName!,
          onTap: null,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(conxt),
            child: const Text(
              'CANCEL',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              task = FirebaseApi.uploadFile(destination, file);
              setState(() {});

              if (task == null) return;

              final snapshot = await task!.whenComplete(() {});
              final urlDownload = await snapshot.ref.getDownloadURL();

              DatabaseService(
                orgId: userData.orgId,
                uid: userData.uid,
                grupId: widget.grups.grupId,
              ).updateFileData(Files(
                fileName: basenameWithoutExtension(file.path),
                fileUrl: urlDownload,
              ));
            },
            child: const Text(
              'UPLOAD',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FileCard extends StatelessWidget {
  FileCard({
    Key? key,
    required this.fileName,
    required this.userName,
    required this.onTap,
  }) : super(key: key);

  final String fileName;
  final String userName;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Material(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: const Color(0xffE4F0D7),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                Icons.folder,
                color: colorScheme.primaryVariant,
                size: 36,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$fileName',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                      color: Colors.grey[800],
                      fontFamily: GoogleFonts.lekton().fontFamily,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Sent by $userName',
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      color: Colors.grey[600],
                      fontFamily: GoogleFonts.lekton().fontFamily,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatsPageWidget extends StatefulWidget {
  ChatsPageWidget({
    Key? key,
    required this.data,
    required this.grups,
    required this.web,
    required this.userData,
  }) : super(key: key);

  List<Messages> data;
  Groups grups;
  bool web = false;
  UsersData userData;

  @override
  State<ChatsPageWidget> createState() => _ChatsPageWidgetState();
}

class _ChatsPageWidgetState extends State<ChatsPageWidget> {
  TextEditingController controller = TextEditingController();

  ScrollController scrollController = ScrollController();
  final _key = GlobalKey<FormState>();
  FocusNode _focusNode = FocusNode();

  final ImagePicker _picker = ImagePicker();

  UploadTask? task;

  String? message;
  int type = 0;
  bool isImportant = false;

  File? file;

  @override
  Widget build(BuildContext context) {
    UsersData userData = Provider.of<UsersData>(context);

    return Form(
      key: _key,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              reverse: true,
              itemCount: widget.data.length,
              itemBuilder: (context, index) {
                return MessageWidget(
                  msgs: widget.data,
                  web: widget.web,
                  index: index,
                  grups: widget.grups,
                  userData: widget.userData,
                );
              },
            ),
          ),
          widget.userData.isAdmin! || widget.userData.isTeacher!
              ? SafeArea(
                  child: Column(
                    children: [
                      const Divider(
                        thickness: 0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 0.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (value) => value!.isNotEmpty
                                    ? null
                                    : 'Enter School Email',
                                controller: controller,
                                onChanged: (val) {
                                  setState(() => message = val.trim());
                                },
                                textCapitalization:
                                    TextCapitalization.sentences,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                                focusNode: _focusNode,
                                decoration: const InputDecoration(
                                  filled: false,
                                  hintText: 'Type your message',
                                  hintStyle: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                ),
                                //keyboardType: TextInputType.phone,
                                autocorrect: true,
                                maxLines: null,
                              ),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              XFile? image = await _picker.pickImage(
                                source: ImageSource.gallery,
                              );

                              setState(() => file = File(image!.path));
                              await uploadFile(
                                  context, image!.path, 1, userData);
                              //print(image);
                            },
                            icon: const Icon(
                              Icons.image_outlined,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              XFile? image = await _picker.pickImage(
                                  source: ImageSource.camera);

                              setState(() => file = File(image!.path));
                              await uploadFile(
                                  context, image!.path, 1, userData);
                            },
                            icon: const Icon(
                              Icons.photo_camera_outlined,
                            ),
                          ),
                          const IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.movie_creation_outlined,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isImportant = !isImportant;
                              });
                            },
                            icon: Icon(
                              isImportant
                                  ? Icons.label_important
                                  : Icons.label_important_outline,
                              color: isImportant
                                  ? Colors.indigo[500]
                                  : Colors.grey[800],
                            ),
                          ),
                          Expanded(child: Container()),
                          IconButton(
                            onPressed: () async {
                              if (_key.currentState!.validate()) {
                                controller.clear();
                                await DatabaseService(
                                  orgId: widget.userData.orgId,
                                  grupId: widget.grups.grupId,
                                  uid: widget.userData.uid,
                                ).updateMessageData(Messages(
                                  content: message,
                                  type: type,
                                  isImportant: isImportant,
                                ));
                                await DatabaseService(
                                  orgId: widget.userData.orgId,
                                  grupId: widget.grups.grupId,
                                  uid: widget.userData.uid,
                                ).updateLastMessage(Messages(
                                  content: message,
                                  type: type,
                                  isImportant: isImportant,
                                ));
                                setState(() {
                                  isImportant = false;
                                });

                                _focusNode.unfocus();
                              }
                            },
                            icon: const Icon(
                              Icons.send_sharp,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Future uploadFile(BuildContext context, String imageUrl, int type,
      UsersData userData) async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination =
        'media/${userData.orgId}/${widget.grups.grupId}/images/$fileName';
    type == 1 ? showImageDialog(context, imageUrl, destination) : null;
  }

  showImageDialog(BuildContext context, String imageUrl, destination) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (conxt) => AlertDialog(
        contentPadding: EdgeInsets.only(top: 12),
        backgroundColor: colorScheme.surface.withOpacity(0.9),
        title: Center(
            child: Text(
          'SEND IMAGE',
          style: TextStyle(
            fontFamily: GoogleFonts.lekton().fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 24.0,
            color: colorScheme.onSurface,
          ),
        )),
        content: file != null
            ? Image.file(file!)
            : const Center(child: CircularProgressIndicator()),
        actions: [
          ElevatedButton(
            onPressed: () async {
              task = FirebaseApi.uploadFile(destination, file!);
              setState(() {});

              if (task == null) return;

              final snapshot = await task!.whenComplete(() {});
              final urlDownload = await snapshot.ref.getDownloadURL();

              await DatabaseService(
                orgId: widget.userData.orgId,
                grupId: widget.grups.grupId,
                uid: widget.userData.uid,
              ).updateMessageData(Messages(
                content: urlDownload,
                type: 1,
                isImportant: isImportant,
              ));

              await DatabaseService(
                orgId: widget.userData.orgId,
                grupId: widget.grups.grupId,
                uid: widget.userData.uid,
              ).updateLastMessage(Messages(
                content: urlDownload,
                type: 1,
                isImportant: isImportant,
              ));

              Navigator.pop(conxt);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('SEND'.toUpperCase()),
              ],
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(conxt),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('CANCEL'.toUpperCase()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
