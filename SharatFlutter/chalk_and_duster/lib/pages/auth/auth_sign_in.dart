import 'package:chalk_and_duster/pages/auth/create/auth_create.dart';
import 'package:chalk_and_duster/pages/auth/create/auth_web_createorg.dart';
import 'package:chalk_and_duster/services/auth.dart';
import 'package:chalk_and_duster/widgets/text_field.dart';
import 'package:chalk_and_duster/widgets/widget_grid.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'loading.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();

  final Function? toggleView;
  SignInPage({this.toggleView});
}

class _SignInPageState extends State<SignInPage> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : ResponsiveBuilder(
            breakpoints:
                ScreenBreakpoints(desktop: 600, tablet: 200, watch: 100),
            builder: (context, sizingInfo) =>
                sizingInfo.isDesktop ? LoginDesktopPage() : LoginMobilePage());
  }
}

class LoginDesktopPage extends StatefulWidget {
  const LoginDesktopPage({Key? key}) : super(key: key);

  @override
  State<LoginDesktopPage> createState() => _LoginDesktopPageState();
}

class _LoginDesktopPageState extends State<LoginDesktopPage> {
  final myController = TextEditingController();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _formKeyPass = GlobalKey<FormState>();
  String error = '';

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

    return Scaffold(
      //backgroundColor: secondary,
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: width! / 4, vertical: hight! / 8),
        child: Center(
          child: Wrap(
            children: [
              Container(
                //color: primary,
                padding: EdgeInsets.only(
                    top: 30.0, right: 16.0, left: 16.0, bottom: 30.0),
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
                          // color: accentDark,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        validator: (val) =>
                            val!.isNotEmpty ? null : 'Enter Mobile No. ',
                        onChanged: (val) {
                          setState(() => email = val.trim());
                        },
                        decoration: textInputDecoration("Enter Mobile No."),
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
                                  // backgroundColor: secondary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  title: Text(
                                    "Forgot Password",
                                    style: TextStyle(
                                        //  color: accentDark,
                                        ),
                                  ),
                                  content: Form(
                                    key: _formKeyPass,
                                    child: TextFormField(
                                      validator: (val) => val!.isNotEmpty
                                          ? null
                                          : 'Enter Mobile No.',
                                      decoration: textInputDecoration(
                                          "Enter Mobile No."),
                                      controller: myController,
                                    ),
                                  ),
                                  actions: [
                                    FlatButton(
                                      //   textColor: accentDark,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('CANCEL'),
                                    ),
                                    FlatButton(
                                      //     textColor: accentDark,
                                      //   color: accent,
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
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: RaisedButton(
                          //  color: accent,
                          onPressed: () async {
                            setState(() => loading = true);
                            if (_formKey.currentState!.validate()) {
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error =
                                      'Email or password is incorrect. If not created register';
                                });
                              }
                            }
                          },
                          child: Text(
                            'LOG IN',
                            //style: TextStyle(color: accentDark),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateOrgPage()),
                          );
                        },
                        child: Text(
                          "Buy Lisence",
                          style: TextStyle(
                              //color: accent.withOpacity(0.5),
                              ),
                        ),
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
}

class LoginMobilePage extends StatefulWidget {
  const LoginMobilePage({Key? key}) : super(key: key);

  @override
  _LoginMobilePageState createState() => _LoginMobilePageState();
}

class _LoginMobilePageState extends State<LoginMobilePage> {
  // text field state
  String email = '';
  String password = '';
  bool _showPass = true;
  bool loading = false;

  double? width;
  double? hight;

  double? progress;
  String? progBar;

  final _formKeyPass = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  final myController = TextEditingController();
  final AuthService _auth = AuthService();

  String error = '';

  @override
  Widget build(BuildContext context) {
    setState(() {
      width = MediaQuery.of(context).size.width;
      hight = MediaQuery.of(context).size.height;
    });
    return Scaffold(
      backgroundColor: Colors.amber[50],
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Sign In',
                style: TextStyle(
                    fontSize: 52.0,
                    fontFamily: GoogleFonts.eczar().fontFamily,
                    fontWeight: FontWeight.bold
                    // color: accentDark,
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
                validator: (val) => val!.isEmpty ? 'Enter Password' : null,
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
                          //backgroundColor: secondary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          title: Text(
                            "Forgot Password",
                            style: TextStyle(
                                // color: accentDark,
                                ),
                          ),
                          content: Form(
                            key: _formKeyPass,
                            child: TextFormField(
                              validator: (val) =>
                                  val!.isNotEmpty ? null : 'Enter Mobile No.',
                              decoration:
                                  textInputDecoration("Enter Mobile No."),
                              controller: myController,
                            ),
                          ),
                          actions: [
                            FlatButton(
                              //textColor: accentDark,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('CANCEL'),
                            ),
                            FlatButton(
                              // textColor: accentDark,
                              //color: accent,
                              onPressed: () async {
                                if (_formKeyPass.currentState!.validate()) {
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
                  //color: secondary,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateUsersPage()));
                  },
                  child: Text(
                    'BUY',
                    //style: TextStyle(color: accentDark),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          // backgroundColor: accent,
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
