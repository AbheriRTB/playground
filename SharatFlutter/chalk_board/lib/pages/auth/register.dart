import 'package:flutter/material.dart';
import 'package:chalk_board/services/auth.dart';
import 'package:chalk_board/utils/text_input_signin.dart';

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                      fontSize: 34,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                      backgroundColor: Colors.amber[200],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter an name' : null,
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                  decoration: textInputDecoration("Enter Name"),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) => val.isNotEmpty ? null : 'Enter an email',
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
                  validator: (val) =>
                      val.length < 8 ? 'Enter a password 8+ chars long' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Enter Password",
                    suffixIcon: IconButton(
                      icon: Icon(_showPass
                          ? Icons.visibility_off
                          : Icons.remove_red_eye),
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
                Divider(),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: () async {
                    try {
                      await _auth.signInWithGoogle();
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
                        'lib/assets/images/google.png',
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
                      await _auth.signInAnon("");
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
                InkWell(
                  onTap: () => widget.toggleView(),
                  child: Text(
                    "Aldready have an account? Login",
                    style: TextStyle(
                        color: Colors.grey[600], fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: Text(
            "REGISTER",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
