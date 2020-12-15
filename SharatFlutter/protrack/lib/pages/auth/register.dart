import 'package:flutter/material.dart';
import 'package:protrack/services/auth.dart';
import 'package:protrack/utils/text_field.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String name = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Center(
                  child: Text(
                "Register",
                style: TextStyle(fontSize: 64, color: Colors.grey[600]),
              )),
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
                validator: (val) => val.isNotEmpty && val.endsWith("@abheri.co")
                    ? null
                    : 'Enter an email ending with @abheri.co',
                onChanged: (val) {
                  setState(() => email = val);
                },
                decoration: textInputDecoration("Enter Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  obscureText: true,
                  validator: (val) =>
                      val.length < 8 ? 'Enter a password 8+ chars long' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  decoration: textInputDecoration("Enter Password")),
              SizedBox(height: 20.0),
              TextFormField(
                  obscureText: true,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Re-Enter New Password";
                    } else if (val.length < 8) {
                      return "Password must be atleast 8 characters long";
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
              MaterialButton(
                  onPressed: () => widget.toggleView(), child: Text("SignIn")),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.lime,

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
            if (_formKey.currentState.validate()) {
              dynamic result = await _auth.registerWithEmailAndPassword(
                  email, password, name);
              if (result == null) {
                setState(() {
                  error = 'Email aldready taklen';
                });
              }
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
