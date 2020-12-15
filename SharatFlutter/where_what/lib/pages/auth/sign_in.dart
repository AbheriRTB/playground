import 'package:flutter/material.dart';
import 'package:where_what/services/auth.dart';
import 'package:where_what/utils/text_input_signin.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();

  final Function toggleView;
  SignInPage({this.toggleView});
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Center(
                  child: Text(
                "Sign In",
                style: TextStyle(fontSize: 64, color: Colors.grey[600]),
              )),
              SizedBox(height: 20.0),
              TextFormField(
                  validator: (val) => val.isNotEmpty
                      ? null
                      : 'Enter an email ending with @abheri.co',
                  onChanged: (val) {
                    setState(() => email = val.trim());
                  },
                  decoration: textInputDecoration("Enter Email"),
                  keyboardType: TextInputType.emailAddress),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                validator: (val) =>
                    val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
                decoration: textInputDecoration("Enter Password"),
              ),
              SizedBox(height: 12.0),
              MaterialButton(
                  onPressed: () => widget.toggleView(),
                  child: Text("Register")),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.indigo,
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
            if (_formKey.currentState.validate()) {
              dynamic result =
                  await _auth.signInWithEmailAndPassword(email, password);
              if (result == null) {
                setState(() {
                  error =
                      'Please supply a valid email (It might be aldready talken)';
                });
              }
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
