import 'package:flutter/material.dart';
import 'package:where_what/services/auth.dart';
import 'package:where_what/utils/text_input_signin.dart';
import 'loading.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;
  RegisterPage({this.toggleView});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String name = '';
  String password = '';
  bool _showPass = true;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Center(
                          child: Text(
                        "REGISTER",
                        style: TextStyle(
                            fontSize: 64,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold),
                      )),
                      SizedBox(height: 20.0),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Enter an name' : null,
                        onChanged: (val) {
                          setState(() => name = val);
                        },
                        decoration: textInputDecoration("Enter Name"),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        validator: (val) =>
                            val.isNotEmpty ? null : 'Enter an email',
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                        decoration: textInputDecoration("Enter Email",
                            indicator:
                                "Enter proper email for reset password later."),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: _showPass,
                        validator: (val) => val.length < 8
                            ? 'Enter a password 8+ chars long'
                            : null,
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
                      SizedBox(height: 20.0),
                      TextFormField(
                          obscureText: true,
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please Re-Enter New Password";
                            } else if (val != password) {
                              return "Password must be same as above";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          decoration: textInputDecoration("Conform Password")),
                      SizedBox(height: 12.0),
                      FlatButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          onPressed: () => widget.toggleView(),
                          child: Text("SIGN-IN",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold))),
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
                              error =
                                  "There was a problem signing in! Try again later";
                            });
                          }
                        },
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/search.png',
                              height: 16,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              'SIGN IN WITH GOOGLE',
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () async {
                          try {
                            dynamic result = await _auth.signInAnon("");
                          } catch (e) {
                            setState(() {
                              loading = false;
                              error =
                                  "There was a problem signing in! Try again later";
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
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        error,
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: new BottomAppBar(
              color: Colors.red,
              // Menu
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SizedBox(
                  height: 32,
                ),
              ),

              // Anchor
              //shape: CircularNotchedRectangle(),
            ),
            floatingActionButton: FloatingActionButton.extended(
                label: Text("Register"),
                icon: Icon(Icons.transit_enterexit),
                onPressed: () async {
                  setState(() => loading = true);
                  if (_formKey.currentState.validate()) {
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        email, password, name);
                    if (result == null) {
                      setState(() {
                        loading = false;
                        error = 'Email aldready taklen';
                      });
                    }
                  }
                }),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
  }
}
