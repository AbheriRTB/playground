import 'dart:typed_data';

import 'package:chalk_and_duster/widgets/text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateOrgPage extends StatefulWidget {
  const CreateOrgPage({Key? key}) : super(key: key);

  @override
  _CreateOrgPageState createState() => _CreateOrgPageState();
}

class _CreateOrgPageState extends State<CreateOrgPage> {
  Color primary = Color(0xff303242);
  Color secondary = Color(0xff394359);
  Color accentDark = Color(0xffE0C097);
  Color accent = Color(0xffB85C38);

  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String error = '';

// text field state
  String email = '';
  String password = '';
  bool loading = false;

  UploadTask? task;
  Uint8List? file;

  String? progBar = 'UPLOAD EXCEL';

  double? progress = 0;
  double? width;
  double? hight;

  @override
  Widget build(BuildContext context) {
    setState(() {
      width = MediaQuery.of(context).size.width;
      hight = MediaQuery.of(context).size.height;
    });
    return Scaffold(
      backgroundColor: secondary,
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: width! / 4, vertical: hight! / 8),
        child: Center(
          child: Wrap(
            children: [
              Container(
                color: primary,
                padding: EdgeInsets.only(
                    top: 60.0, right: 16.0, left: 16.0, bottom: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'CREATE',
                        style: TextStyle(
                          fontSize: 38.0,
                          color: accentDark,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        validator: (val) =>
                            val!.isNotEmpty ? null : 'Enter Orginazation Name',
                        onChanged: (val) {
                          setState(() => email = val.trim());
                        },
                        decoration:
                            textInputDecoration("Enter Orginazation Name"),
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () async {
                            await chooseFile();
                          },
                          color: secondary,
                          child: Text(
                            '$progBar',
                            style: TextStyle(color: accentDark),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            color: accent,
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.grey[800],
                            ),
                          ),
                          RaisedButton(
                            color: accent,
                            onPressed: () async {},
                            child: Text(
                              'NEXT',
                              style: TextStyle(color: accentDark),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future chooseFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null) {
      Uint8List? file = result.files.first.bytes;
      String fileName = result.files.first.name;

      UploadTask task = FirebaseStorage.instance
          .ref()
          .child("files/$fileName")
          .putData(file!);

      task.snapshotEvents.listen((event) {
        setState(() {
          progress = ((event.bytesTransferred.toDouble() /
                      event.totalBytes.toDouble()) *
                  100)
              .roundToDouble();

          print(progress);
          progBar = progress.toString() + '%';
          if (progBar == '100%') {
            progBar = 'DONE!';
          }
        });
      });
    }
  }
}
