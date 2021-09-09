import 'package:flutter/material.dart';
import 'package:trench/services/auth.dart';
import 'package:trench/widgets/text_field.dart';
import 'loading.dart';

class RegisterPage extends StatefulWidget {
  final Function? toggleView;
  RegisterPage({this.toggleView});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Color primary = Color(0xff303242);
  Color secondary = Color(0xff394359);
  Color accentDark = Color(0xffE0C097);
  Color accent = Color(0xffB85C38);

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
            backgroundColor: primary,
            //resizeToAvoidBottomPadding: false,
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 38.0,
                          color: accentDark,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an name' : null,
                        onChanged: (val) {
                          setState(() => name = val);
                        },
                        decoration: textInputDecoration("Enter Name"),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        validator: (val) =>
                            val!.isNotEmpty ? null : 'Enter an email',
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
                        validator: (val) => val!.length < 8
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
                            if (val!.isEmpty) {
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
                          color: secondary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () => widget.toggleView!(),
                          child: Text("SIGN-IN",
                              style: TextStyle(
                                  color: accentDark,
                                  fontWeight: FontWeight.bold))),
                      Divider(
                        color: accent,
                      ),
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
                        color: secondary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'lib/assets/images/search.png',
                              height: 16,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              'SIGN IN WITH GOOGLE',
                              style: TextStyle(
                                  color: accentDark,
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
                        color: secondary,
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
                                  color: accentDark,
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

            floatingActionButton: FloatingActionButton.extended(
                label: Text("Register"),
                backgroundColor: accent,
                onPressed: () async {
                  /*
                  setState(() => loading = true);
                  if (_formKey.currentState!.validate()) {
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        email, password, name);
                    if (result == null) {
                      setState(() {
                        loading = false;
                        error = 'Email aldready taklen';
                      });
                    }
                  }*/
                }),
          );
  }
}
