import 'package:flutter/material.dart';
import 'package:where_what/services/auth.dart';
import 'package:where_what/utils/text_input_signin.dart';
import 'loading.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();

  final Function toggleView;
  SignInPage({this.toggleView});
}

class _SignInPageState extends State<SignInPage> {
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
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Center(
                        child: Text(
                      "SIGN IN",
                      style: TextStyle(
                          fontSize: 64,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold),
                    )),
                    SizedBox(height: 20.0),
                    TextFormField(
                        validator: (val) =>
                            val.isNotEmpty ? null : 'Enter an email ',
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
                                    validator: (val) => val.isNotEmpty
                                        ? null
                                        : 'Enter an email',
                                    decoration:
                                        textInputDecoration("Enter Email"),
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
                                      if (_formKeyPass.currentState
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
                    FlatButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      onPressed: () => widget.toggleView(),
                      child: Text(
                        "REGISTER",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
                          //dynamic result = await _auth.signInWithGoogle();
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
                  ],
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
            ),
            floatingActionButton: FloatingActionButton.extended(
                label: Text("Log In"),
                icon: Icon(Icons.transit_enterexit),
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
  }
}
