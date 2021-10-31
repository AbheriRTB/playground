import 'package:jotted/pages/auth/create/auth_create.dart';
import 'package:jotted/pages/auth/create/auth_enroll.dart';
import 'package:jotted/services/auth.dart';
import 'package:jotted/widgets/widget_text_field.dart';
import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';

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
    return ResponsiveBuilder(
        breakpoints:
            const ScreenBreakpoints(desktop: 600, tablet: 200, watch: 100),
        builder: (context, sizingInfo) => sizingInfo.isDesktop
            ? const LoginDesktopPage()
            : const LoginMobilePage());
  }
}

class LoginDesktopPage extends StatefulWidget {
  const LoginDesktopPage({Key? key}) : super(key: key);

  @override
  State<LoginDesktopPage> createState() => _LoginDesktopPageState();
}

class _LoginDesktopPageState extends State<LoginDesktopPage> {
  final myController = TextEditingController();
  final passController = TextEditingController();
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
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    setState(() {
      width = MediaQuery.of(context).size.width;
      hight = MediaQuery.of(context).size.height;
    });

    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: width! / 4, vertical: hight! / 12),
        child: Container(
          color: colorScheme.surface.withOpacity(0.09),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Wrap(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AnimatedOpacity(
                          child: const LinearProgressIndicator(),
                          opacity: loading ? 1 : 0,
                          duration: Duration(seconds: 1),
                        ),
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 60.0,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.secondary,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          validator: (val) =>
                              val!.isNotEmpty ? null : 'Enter School Email',
                          enabled: !loading,
                          onChanged: (val) {
                            setState(() => email = val.trim());
                          },
                          decoration: textInputDecoration("Enter School Email"),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          obscureText: _showPass,
                          validator: (val) =>
                              val!.isEmpty ? 'Enter Password' : null,
                          enabled: !loading,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          decoration: InputDecoration(
                            labelText: "Enter Password",
                            suffixIcon: IconButton(
                              icon:
                                  //progress: animationController!,
                                  Icon(_showPass
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off),
                              color: Colors.grey[800],
                              onPressed: () {
                                setState(() {
                                  _showPass = !_showPass;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ForgotAlert(
                                      formKeyPass: _formKeyPass,
                                      myController: myController,
                                      auth: _auth);
                                },
                              );
                            },
                            child: Text(
                              "Forgot Password?".toUpperCase(),
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 42,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton.extended(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            onPressed: () async {
                              setState(() => loading = true);
                              if (_formKey.currentState!.validate()) {
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                  });
                                  const snackBar = SnackBar(
                                    behavior: SnackBarBehavior.fixed,
                                    content: Text(
                                      'Email or password is incorrect',
                                    ),
                                    elevation: 1,
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              }
                            },
                            icon: const Icon(
                              Icons.transit_enterexit,
                            ),
                            label: const Text(
                              'LOG IN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ForgotAlert extends StatelessWidget {
  const ForgotAlert({
    Key? key,
    required GlobalKey<FormState> formKeyPass,
    required this.myController,
    required AuthService auth,
  })  : _formKeyPass = formKeyPass,
        _auth = auth,
        super(key: key);

  final GlobalKey<FormState> _formKeyPass;
  final TextEditingController myController;
  final AuthService _auth;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //backgroundColor: secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(
        "Forgot Password",
        style: TextStyle(
            // color: accentDark,
            ),
      ),
      content: Form(
        key: _formKeyPass,
        child: TextFormField(
          validator: (val) => val!.isNotEmpty ? null : 'Enter Email',
          decoration: textInputDecoration("Enter Email"),
          controller: myController,
        ),
      ),
      backgroundColor: Colors.indigo[900]!.withOpacity(0.9),
      actions: [
        TextButton(
          //textColor: accentDark,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        ),
        ElevatedButton(
          // textColor: accentDark,
          //color: accent,
          onPressed: () async {
            if (_formKeyPass.currentState!.validate()) {
              await _auth.sendPasswordResetEmail(myController.text);
              Navigator.pop(context);
            }
          },
          child: Text('SEND'),
        ),
      ],
    );
  }
}

class LoginMobilePage extends StatefulWidget {
  const LoginMobilePage({Key? key}) : super(key: key);

  @override
  _LoginMobilePageState createState() => _LoginMobilePageState();
}

class _LoginMobilePageState extends State<LoginMobilePage>
    with SingleTickerProviderStateMixin {
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
  bool isChanged = false;

  AnimationController? animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  dispose() {
    animationController!.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    void trigger() {
      isChanged = !isChanged;
      isChanged
          ? animationController!.forward()
          : animationController!.reverse();
    }

    setState(() {
      width = MediaQuery.of(context).size.width;
      hight = MediaQuery.of(context).size.height;
    });
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 46.0, horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24.0,
              ),
              Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 32.0),
              TextFormField(
                validator: (val) =>
                    val!.isNotEmpty ? null : 'Enter School Email',
                enabled: !loading,
                onChanged: (val) {
                  setState(() => email = val.trim());
                },
                decoration: textInputDecoration("Enter School Email"),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                obscureText: _showPass,
                validator: (val) => val!.isEmpty ? 'Enter Password' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
                decoration: InputDecoration(
                  labelText: "Enter Password",
                  suffixIcon: IconButton(
                    icon:
                        //progress: animationController!,
                        Icon(_showPass
                            ? Icons.remove_red_eye
                            : Icons.visibility_off),
                    color: Colors.grey[800],
                    onPressed: () {
                      setState(() {
                        trigger();
                        _showPass = !_showPass;
                      });
                    },
                    hoverColor: Colors.grey[800],
                    splashColor: Colors.grey[800],
                  ),
                ),
                autocorrect: false,
              ),
              //SizedBox(height: 12.0),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ForgotAlert(
                            formKeyPass: _formKeyPass,
                            myController: myController,
                            auth: _auth);
                      },
                    );
                  },
                  child: Text(
                    "Forgot Password?".toUpperCase(),
                    style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: colorScheme.error, fontSize: 14.0),
              ),
              Expanded(child: Container()),
              Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OrgIdEnroll()));
                      },
                      child: Text(
                        'Enroll Now.',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateUsersPage()));
                      },
                      child: Text(
                        'Dont have a lisence? Buy.',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: loading
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:
                      CircularProgressIndicator(color: colorScheme.onSecondary))
              : Icon(Icons.transit_enterexit, color: colorScheme.onSecondary),
          onPressed: () async {
            setState(() => loading = true);
            if (_formKey.currentState!.validate()) {
              dynamic result =
                  await _auth.signInWithEmailAndPassword(email, password);
              if (result == null) {
                setState(() {
                  loading = false;
                });
                final snackBar = SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    'Email or password is incorrect',
                    style: TextStyle(
                        color: colorScheme.onSurface.withOpacity(0.4)),
                  ),
                  elevation: 1,
                  backgroundColor: colorScheme.surface,
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            } else {
              setState(() {
                loading = false;
              });
            }
          }),
    );
  }
}
