import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:trench/pages/home/home.dart';
import 'package:trench/services/auth.dart';
import 'package:trench/widgets/text_field.dart';
import 'loading.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();

  final Function? toggleView;
  SignInPage({this.toggleView});
}

class _SignInPageState extends State<SignInPage> {
  final myController = TextEditingController();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _formKeyPass = GlobalKey<FormState>();
  String error = '';

  Color primary = Color(0xff303242);
  Color secondary = Color(0xff394359);
  Color accentDark = Color(0xffE0C097);
  Color accent = Color(0xffB85C38);

  // text field state
  String email = '';
  String password = '';
  bool _showPass = true;
  bool loading = false;

  double? width;
  double? hight;

  double? progress;
  String? progBar;

  @override
  Widget build(BuildContext context) {
    setState(() {
      width = MediaQuery.of(context).size.width;
      hight = MediaQuery.of(context).size.height;
    });
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: primary,
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 38.0,
                        color: accentDark,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) =>
                          val!.isNotEmpty ? null : 'Enter School Email',
                      onChanged: (val) {
                        setState(() => email = val.trim());
                      },
                      decoration: textInputDecoration("Enter School Email"),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: _showPass,
                      validator: (val) =>
                          val!.isEmpty ? 'Enter Password' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Enter Password",
                        suffixIcon: IconButton(
                          icon: Icon(_showPass
                              ? Icons.remove_red_eye
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _showPass = !_showPass;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: secondary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                title: Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                    color: accentDark,
                                  ),
                                ),
                                content: Form(
                                  key: _formKeyPass,
                                  child: TextFormField(
                                    validator: (val) => val!.isNotEmpty
                                        ? null
                                        : 'Enter Mobile No.',
                                    decoration:
                                        textInputDecoration("Enter Mobile No."),
                                    controller: myController,
                                  ),
                                ),
                                actions: [
                                  FlatButton(
                                    textColor: accentDark,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('CANCEL'),
                                  ),
                                  FlatButton(
                                    textColor: accentDark,
                                    color: accent,
                                    onPressed: () async {
                                      if (_formKeyPass.currentState!
                                          .validate()) {
                                        await _auth.sendPasswordResetEmail(
                                            myController.text);
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text('SEND'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: RaisedButton(
                        color: secondary,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                        child: Text(
                          'BUY',
                          style: TextStyle(color: accentDark),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                backgroundColor: accent,
                label: Text(
                  "Log In",
                ),
                // icon: Icon(Icons.transit_enterexit),
                onPressed: () async {
                  setState(() => loading = true);
                  if (_formKey.currentState!.validate()) {
                    dynamic result =
                        await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        loading = false;
                        error =
                            'Email or password is incorrect. If not created register';
                      });
                    }
                  }
                }),
          );
  }
}
