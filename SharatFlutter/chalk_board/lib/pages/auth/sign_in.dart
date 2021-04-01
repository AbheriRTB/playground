import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chalk_board/services/auth.dart';
import 'package:chalk_board/utils/text_input_signin.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();

  final Function toggleView;
  LogInPage({this.toggleView});
}

class _LogInPageState extends State<LogInPage> {
  final myController = TextEditingController();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _formKeyPass = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';
  bool _showPass = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "LOG IN",
                  style: TextStyle(
                      fontSize: 34,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                      backgroundColor: Colors.amber[200]),
                ),
              ),
              SizedBox(height: 50.0),
              TextFormField(
                  validator: (val) => val.isNotEmpty ? null : 'Enter an email ',
                  onChanged: (val) {
                    setState(() => email = val.trim());
                  },
                  decoration: textInputDecoration("Enter Email"),
                  keyboardType: TextInputType.emailAddress),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: _showPass,
                validator: (val) => val.isEmpty ? 'Enter Password' : null,
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          title: Text(
                            "Forgot Password",
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          content: Form(
                            key: _formKeyPass,
                            child: TextFormField(
                              validator: (val) =>
                                  val.isNotEmpty ? null : 'Enter an email',
                              decoration: textInputDecoration("Enter Email"),
                              controller: myController,
                            ),
                          ),
                          actions: [
                            FlatButton(
                              textColor: Colors.red,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('CANCEL'),
                            ),
                            FlatButton(
                              textColor: Colors.red,
                              onPressed: () async {
                                if (_formKeyPass.currentState.validate()) {
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
              Divider(),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onPressed: () async {
                  try {
                    dynamic result = await _auth.signInWithGoogle();
                  } catch (e) {
                    setState(() {
                      loading = false;
                      error = "There was a problem signing in! Try again later";
                    });
                  }
                },
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/google.png',
                      height: 16,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      'SIGN IN WITH GOOGLE',
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onPressed: () async {
                  try {
                    dynamic result = await _auth.signInAnon('');
                  } catch (e) {
                    setState(() {
                      loading = false;
                      error = "There was a problem signing in! Try again later";
                    });
                  }
                },
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.supervised_user_circle,
                      size: 22,
                      color: Colors.amber,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      'SIGN IN AS GUEST',
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 52.0,
              ),
              InkWell(
                onTap: () => widget.toggleView(),
                child: Text(
                  "Don't have an account? Register",
                  style: TextStyle(
                      color: Colors.grey[600], fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: Text(
            "LOG IN",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () async {
            setState(() => loading = true);
            if (_formKey.currentState.validate()) {
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
