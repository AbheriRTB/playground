import 'package:flutter/material.dart';
import 'package:trench/models/codes.dart';
import 'package:trench/pages/auth/auth_sign_in.dart';
import 'package:trench/services/auth.dart';
import 'loading.dart';

class RegisterPage extends StatefulWidget {
  final Function? toggleView;
  RegisterPage({this.toggleView});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  List<ContryCodes> map = [];

  String? name;
  String? email;
  String? password;

  bool? showPass = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            //resizeToAvoidBottomPadding: false,
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
                            'Register'.toUpperCase(),
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
                            validator: (val) =>
                                val!.isEmpty ? 'Enter Name' : null,
                            decoration: InputDecoration(
                              labelText: 'Name',
                            ),
                            cursorColor: Colors.amber,
                            cursorWidth: 3,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                            ),
                            onChanged: (value) {
                              setState(() {
                                name = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
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
                            validator: (val) => val!.length < 8
                                ? 'Enter a password 8+ chars long'
                                : null,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffix: InkWell(
                                onTap: () {
                                  setState(() {
                                    showPass = !showPass!;
                                  });
                                },
                                child: Text(
                                  showPass! ? 'A' : '#',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                splashColor: Colors.black45,
                                highlightColor: Colors.black45,
                              ),
                            ),
                            obscureText: showPass!,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please Re-Enter New Password";
                              } else if (val != password) {
                                return "Password must be same as above";
                              } else {
                                return null;
                              }
                            },
                            obscureText: showPass!,
                            obscuringCharacter: '#',
                            cursorColor: Colors.amber,
                            cursorWidth: 3,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Mobile no.',
                              prefix: InkWell(
                                onTap: () {
                                  buildDialod(context);
                                },
                                child: Text(
                                  '91+ ',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            cursorColor: Colors.amber,
                            cursorWidth: 3,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
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
                              onPressed: () async {
                                await handleRegister(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  'Register',
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
                                    builder: (context) => SignInPage(),
                                  ),
                                );
                              },
                              splashColor: Colors.black45,
                              highlightColor: Colors.black45,
                              child: Text(
                                'Aldready Have an Account? Login',
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

  handleRegister(context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      final result = await AuthService().registerWithEmailAndPassword(
        email!,
        password!,
        name!,
      );
      Navigator.pop(context);
    }
  }

  List<ContryCodes> getAll() {
    List<ContryCodes>? codes = [];
    codes.add(ContryCodes("AC", "+247"));
    codes.add(ContryCodes("AD", "+376"));
    codes.add(ContryCodes("AE", "+971"));
    codes.add(ContryCodes("AF", "+93"));
    codes.add(ContryCodes("AG", "+1-268"));
    codes.add(ContryCodes("AI", "+1-264"));
    codes.add(ContryCodes("AL", "+355"));
    codes.add(ContryCodes("AM", "+374"));
    codes.add(ContryCodes("AN", "+599"));
    codes.add(ContryCodes("AO", "+244"));
    codes.add(ContryCodes("AR", "+54"));
    codes.add(ContryCodes("AS", "+1-684"));
    codes.add(ContryCodes("AT", "+43"));
    codes.add(ContryCodes("AU", "+61"));
    codes.add(ContryCodes("AW", "+297"));
    codes.add(ContryCodes("AX", "+358-18"));
    codes.add(ContryCodes("AZ", "+374-97"));
    codes.add(ContryCodes("AZ", "+994"));
    codes.add(ContryCodes("BA", "+387"));
    codes.add(ContryCodes("BB", "+1-246"));
    codes.add(ContryCodes("BD", "+880"));
    codes.add(ContryCodes("BE", "+32"));
    codes.add(ContryCodes("BF", "+226"));
    codes.add(ContryCodes("BG", "+359"));
    codes.add(ContryCodes("BH", "+973"));
    codes.add(ContryCodes("BI", "+257"));
    codes.add(ContryCodes("BJ", "+229"));
    codes.add(ContryCodes("BM", "+1-441"));
    codes.add(ContryCodes("BN", "+673"));
    codes.add(ContryCodes("BO", "+591"));
    codes.add(ContryCodes("BR", "+55"));
    codes.add(ContryCodes("BS", "+1-242"));
    codes.add(ContryCodes("BT", "+975"));
    codes.add(ContryCodes("BW", "+267"));
    codes.add(ContryCodes("BY", "+375"));
    codes.add(ContryCodes("BZ", "+501"));
    codes.add(ContryCodes("CA", "+1"));
    codes.add(ContryCodes("CC", "+61"));
    codes.add(ContryCodes("CD", "+243"));
    codes.add(ContryCodes("CF", "+236"));
    codes.add(ContryCodes("CG", "+242"));
    codes.add(ContryCodes("CH", "+41"));
    codes.add(ContryCodes("CI", "+225"));
    codes.add(ContryCodes("CK", "+682"));
    codes.add(ContryCodes("CL", "+56"));
    codes.add(ContryCodes("CM", "+237"));
    codes.add(ContryCodes("CN", "+86"));
    codes.add(ContryCodes("CO", "+57"));
    codes.add(ContryCodes("CR", "+506"));
    codes.add(ContryCodes("CS", "+381"));
    codes.add(ContryCodes("CU", "+53"));
    codes.add(ContryCodes("CV", "+238"));
    codes.add(ContryCodes("CX", "+61"));
    codes.add(ContryCodes("CY", "+90-392"));
    codes.add(ContryCodes("CY", "+357"));
    codes.add(ContryCodes("CZ", "+420"));
    codes.add(ContryCodes("DE", "+49"));
    codes.add(ContryCodes("DJ", "+253"));
    codes.add(ContryCodes("DK", "+45"));
    codes.add(ContryCodes("DM", "+1-767"));
    codes.add(ContryCodes("DO", "+1-809")); // and 1-829?
    codes.add(ContryCodes("DZ", "+213"));
    codes.add(ContryCodes("EC", "+593"));
    codes.add(ContryCodes("EE", "+372"));
    codes.add(ContryCodes("EG", "+20"));
    codes.add(ContryCodes("EH", "+212"));
    codes.add(ContryCodes("ER", "+291"));
    codes.add(ContryCodes("ES", "+34"));
    codes.add(ContryCodes("ET", "+251"));
    codes.add(ContryCodes("FI", "+358"));
    codes.add(ContryCodes("FJ", "+679"));
    codes.add(ContryCodes("FK", "+500"));
    codes.add(ContryCodes("FM", "+691"));
    codes.add(ContryCodes("FO", "+298"));
    codes.add(ContryCodes("FR", "+33"));
    codes.add(ContryCodes("GA", "+241"));
    codes.add(ContryCodes("GB", "+44"));
    codes.add(ContryCodes("GD", "+1-473"));
    codes.add(ContryCodes("GE", "+995"));
    codes.add(ContryCodes("GF", "+594"));
    codes.add(ContryCodes("GG", "+44"));
    codes.add(ContryCodes("GH", "+233"));
    codes.add(ContryCodes("GI", "+350"));
    codes.add(ContryCodes("GL", "+299"));
    codes.add(ContryCodes("GM", "+220"));
    codes.add(ContryCodes("GN", "+224"));
    codes.add(ContryCodes("GP", "+590"));
    codes.add(ContryCodes("GQ", "+240"));
    codes.add(ContryCodes("GR", "+30"));
    codes.add(ContryCodes("GT", "+502"));
    codes.add(ContryCodes("GU", "+1-671"));
    codes.add(ContryCodes("GW", "+245"));
    codes.add(ContryCodes("GY", "+592"));
    codes.add(ContryCodes("HK", "+852"));
    codes.add(ContryCodes("HN", "+504"));
    codes.add(ContryCodes("HR", "+385"));
    codes.add(ContryCodes("HT", "+509"));
    codes.add(ContryCodes("HU", "+36"));
    codes.add(ContryCodes("ID", "+62"));
    codes.add(ContryCodes("IE", "+353"));
    codes.add(ContryCodes("IL", "+972"));
    codes.add(ContryCodes("IM", "+44"));
    codes.add(ContryCodes("IN", "+91"));
    codes.add(ContryCodes("IO", "+246"));
    codes.add(ContryCodes("IQ", "+964"));
    codes.add(ContryCodes("IR", "+98"));
    codes.add(ContryCodes("IS", "+354"));
    codes.add(ContryCodes("IT", "+39"));
    codes.add(ContryCodes("JE", "+44"));
    codes.add(ContryCodes("JM", "+1-876"));
    codes.add(ContryCodes("JO", "+962"));
    codes.add(ContryCodes("JP", "+81"));
    codes.add(ContryCodes("KE", "+254"));
    codes.add(ContryCodes("KG", "+996"));
    codes.add(ContryCodes("KH", "+855"));
    codes.add(ContryCodes("KI", "+686"));
    codes.add(ContryCodes("KM", "+269"));
    codes.add(ContryCodes("KN", "+1-869"));
    codes.add(ContryCodes("KP", "+850"));
    codes.add(ContryCodes("KR", "+82"));
    codes.add(ContryCodes("KW", "+965"));
    codes.add(ContryCodes("KY", "+1-345"));
    codes.add(ContryCodes("KZ", "+7"));
    codes.add(ContryCodes("LA", "+856"));
    codes.add(ContryCodes("LB", "+961"));
    codes.add(ContryCodes("LC", "+1-758"));
    codes.add(ContryCodes("LI", "+423"));
    codes.add(ContryCodes("LK", "+94"));
    codes.add(ContryCodes("LR", "+231"));
    codes.add(ContryCodes("LS", "+266"));
    codes.add(ContryCodes("LT", "+370"));
    codes.add(ContryCodes("LU", "+352"));
    codes.add(ContryCodes("LV", "+371"));
    codes.add(ContryCodes("LY", "+218"));
    codes.add(ContryCodes("MA", "+212"));
    codes.add(ContryCodes("MC", "+377"));
    codes.add(ContryCodes("MD", "+373-533"));
    codes.add(ContryCodes("MD", "+373"));
    codes.add(ContryCodes("ME", "+382"));
    codes.add(ContryCodes("MG", "+261"));
    codes.add(ContryCodes("MH", "+692"));
    codes.add(ContryCodes("MK", "+389"));
    codes.add(ContryCodes("ML", "+223"));
    codes.add(ContryCodes("MM", "+95"));
    codes.add(ContryCodes("MN", "+976"));
    codes.add(ContryCodes("MO", "+853"));
    codes.add(ContryCodes("MP", "+1-670"));
    codes.add(ContryCodes("MQ", "+596"));
    codes.add(ContryCodes("MR", "+222"));
    codes.add(ContryCodes("MS", "+1-664"));
    codes.add(ContryCodes("MT", "+356"));
    codes.add(ContryCodes("MU", "+230"));
    codes.add(ContryCodes("MV", "+960"));
    codes.add(ContryCodes("MW", "+265"));
    codes.add(ContryCodes("MX", "+52"));
    codes.add(ContryCodes("MY", "+60"));
    codes.add(ContryCodes("MZ", "+258"));
    codes.add(ContryCodes("NA", "+264"));
    codes.add(ContryCodes("NC", "+687"));
    codes.add(ContryCodes("NE", "+227"));
    codes.add(ContryCodes("NF", "+672"));
    codes.add(ContryCodes("NG", "+234"));
    codes.add(ContryCodes("NI", "+505"));
    codes.add(ContryCodes("NL", "+31"));
    codes.add(ContryCodes("NO", "+47"));
    codes.add(ContryCodes("NP", "+977"));
    codes.add(ContryCodes("NR", "+674"));
    codes.add(ContryCodes("NU", "+683"));
    codes.add(ContryCodes("NZ", "+64"));
    codes.add(ContryCodes("OM", "+968"));
    codes.add(ContryCodes("PA", "+507"));
    codes.add(ContryCodes("PE", "+51"));
    codes.add(ContryCodes("PF", "+689"));
    codes.add(ContryCodes("PG", "+675"));
    codes.add(ContryCodes("PH", "+63"));
    codes.add(ContryCodes("PK", "+92"));
    codes.add(ContryCodes("PL", "+48"));
    codes.add(ContryCodes("PM", "+508"));
    codes.add(ContryCodes("PR", "+1-787")); // and 1-939 ?
    codes.add(ContryCodes("PS", "+970"));
    codes.add(ContryCodes("PT", "+351"));
    codes.add(ContryCodes("PW", "+680"));
    codes.add(ContryCodes("PY", "+595"));
    codes.add(ContryCodes("QA", "+974"));
    codes.add(ContryCodes("RE", "+262"));
    codes.add(ContryCodes("RO", "+40"));
    codes.add(ContryCodes("RS", "+381"));
    codes.add(ContryCodes("RU", "+7"));
    codes.add(ContryCodes("RW", "+250"));
    codes.add(ContryCodes("SA", "+966"));
    codes.add(ContryCodes("SB", "+677"));
    codes.add(ContryCodes("SC", "+248"));
    codes.add(ContryCodes("SD", "+249"));
    codes.add(ContryCodes("SE", "+46"));
    codes.add(ContryCodes("SG", "+65"));
    codes.add(ContryCodes("SH", "+290"));
    codes.add(ContryCodes("SI", "+386"));
    codes.add(ContryCodes("SJ", "+47"));
    codes.add(ContryCodes("SK", "+421"));
    codes.add(ContryCodes("SL", "+232"));
    codes.add(ContryCodes("SM", "+378"));
    codes.add(ContryCodes("SN", "+221"));
    codes.add(ContryCodes("SO", "+252"));
    codes.add(ContryCodes("SO", "+252"));
    codes.add(ContryCodes("SR", "+597"));
    codes.add(ContryCodes("ST", "+239"));
    codes.add(ContryCodes("SV", "+503"));
    codes.add(ContryCodes("SY", "+963"));
    codes.add(ContryCodes("SZ", "+268"));
    codes.add(ContryCodes("TA", "+290"));
    codes.add(ContryCodes("TC", "+1-649"));
    codes.add(ContryCodes("TD", "+235"));
    codes.add(ContryCodes("TG", "+228"));
    codes.add(ContryCodes("TH", "+66"));
    codes.add(ContryCodes("TJ", "+992"));
    codes.add(ContryCodes("TK", "+690"));
    codes.add(ContryCodes("TL", "+670"));
    codes.add(ContryCodes("TM", "+993"));
    codes.add(ContryCodes("TN", "+216"));
    codes.add(ContryCodes("TO", "+676"));
    codes.add(ContryCodes("TR", "+90"));
    codes.add(ContryCodes("TT", "+1-868"));
    codes.add(ContryCodes("TV", "+688"));
    codes.add(ContryCodes("TW", "+886"));
    codes.add(ContryCodes("TZ", "+255"));
    codes.add(ContryCodes("UA", "+380"));
    codes.add(ContryCodes("UG", "+256"));
    codes.add(ContryCodes("US", "+1"));
    codes.add(ContryCodes("UY", "+598"));
    codes.add(ContryCodes("UZ", "+998"));
    codes.add(ContryCodes("VA", "+379"));
    codes.add(ContryCodes("VC", "+1-784"));
    codes.add(ContryCodes("VE", "+58"));
    codes.add(ContryCodes("VG", "+1-284"));
    codes.add(ContryCodes("VI", "+1-340"));
    codes.add(ContryCodes("VN", "+84"));
    codes.add(ContryCodes("VU", "+678"));
    codes.add(ContryCodes("WF", "+681"));
    codes.add(ContryCodes("WS", "+685"));
    codes.add(ContryCodes("YE", "+967"));
    codes.add(ContryCodes("YT", "+262"));
    codes.add(ContryCodes("ZA", "+27"));
    codes.add(ContryCodes("ZM", "+260"));
    codes.add(ContryCodes("ZW", "+263"));
    return codes;
  }

  buildDialod(context2) {
    dynamic value = 0;
    List<ContryCodes> codes = getAll();

    showDialog(
        context: context2,
        builder: (context) {
          return AlertDialog(
            title: Text('Title'),
            content: Container(
              height: 300.0, // Change as per your requirement
              width: 300.0,
              child: ListView.builder(
                  itemCount: codes.length,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      title: Text('${codes[index].name}'),
                      value: index,
                      groupValue: value!,
                      onChanged: (ind) {
                        setState(() => value = ind!);
                        print(value);
                      },
                    );
                  }),
            ),
            actions: [
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ACTION 1'),
              ),
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ACTION 2'),
              ),
            ],
          );
        });
  }
}
