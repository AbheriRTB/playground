import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:trench/pages/auth/auth_register.dart';
import 'package:trench/services/auth.dart';

import 'loading.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();

  final Function? toggleView;
  SignInPage({this.toggleView});
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  bool showPass = true;

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Welcome Back.'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 52.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autocorrect: false,
                            validator: (val) =>
                                val!.isEmpty ? 'Enter Email' : null,
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                            cursorColor: Colors.amber,
                            cursorWidth: 3,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                            ),
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Enter Password' : null,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffix: InkWell(
                                onTap: () {
                                  setState(() {
                                    showPass = !showPass;
                                  });
                                },
                                child: Text(
                                  showPass ? 'A' : '#',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                splashColor: Colors.black45,
                                highlightColor: Colors.black45,
                              ),
                            ),
                            obscureText: showPass,
                            obscuringCharacter: '#',
                            cursorColor: Colors.amber,
                            cursorWidth: 3,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                            ),
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {},
                              splashColor: Colors.black45,
                              highlightColor: Colors.black45,
                              child: Text(
                                'FORGOT PASSWORD?',
                                style: TextStyle(
                                  fontSize: 11.0,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Divider(
                          color: Colors.grey[800],
                          endIndent: 8,
                          indent: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.maxFinite,
                            child: ElevatedButton(
                              onPressed: () {
                                handleLogin();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ),
                                );
                              },
                              splashColor: Colors.black45,
                              highlightColor: Colors.black45,
                              child: Text(
                                'Dont Have an Account? Register',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.grey[800],
                                  ),
                                  Text(
                                    'Back',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      final result = await AuthService().signInWithEmailAndPassword(
        email!,
        password!,
      );
      Navigator.pop(context);
    }
  }
}
