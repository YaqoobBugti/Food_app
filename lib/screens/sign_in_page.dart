import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_ordering/screens/welcome_page.dart';
import 'package:food_ordering/widgets/app_bar.dart';
import 'package:food_ordering/widgets/circular_button.dart';
import 'package:food_ordering/widgets/my_text_field.dart';

class SignInPage extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var lodding = false;
  final _auth = FirebaseAuth.instance;
  String username;
  UserCredential authResult;
  RegExp regex = new RegExp(SignInPage.pattern);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  validationFuction() {
    if (email.text.trim().isEmpty || email.text.trim() == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Email is empty'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      return;
    } else if (!regex.hasMatch(email.text)) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Please Enter Valid Email'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      return;
    }
    if (password.text.isEmpty || password.text.trim() == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Password is empty'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      return;
    }
    if (password.text.length < 8) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Password is too short'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).accentColor,
      appBar: appBar(
        backButtonPress: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => WelcomePage(),
            ),
          );
        },
        context: context,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ListTile(
              leading: Text(
                "Sign in",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Expanded(
              child: Container(
                //color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        MyTextField(
                          textEditingController: email,
                          hintText: "E-mail",
                          forgetPassword: '',
                          obscureText: false,
                          textInputType: TextInputType.emailAddress,
                        ),
                        MyTextField(
                          textEditingController: password,
                          forgetPassword: 'Forget password?',
                          hintText: 'Password',
                          obscureText: false,
                          textInputType: TextInputType.visiblePassword,
                        ),
                      ],
                    ),
                    Container(
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (lodding)
                            CircularProgressIndicator(
                              backgroundColor: Colors.pink,
                            ),
                          if (!lodding)
                            CircularButton(
                              title: "Log In",
                              buttonColor: Theme.of(context).primaryColor,
                              boderColor: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              whenPress: () async {
                                try {
                                  setState(() {
                                    lodding = true;
                                  });
                                  authResult =
                                      await _auth.signInWithEmailAndPassword(
                                          email: email.text,
                                          password: password.text);
                                } on PlatformException catch (err) {
                                  var massage =
                                      "An error occurred ,please check your credentials";
                                  if (err.message != null) {
                                    _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text(massage),
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                      ),
                                    );
                                  }
                                  setState(() {
                                    lodding = false;
                                  });
                                  // validationFuction();
                                }
                              },
                            ),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 2,
                                  endIndent: 15,
                                  color: Colors.grey,
                                ),
                              ),
                              Center(
                                child: Text(
                                  "OR",
                                  style: TextStyle(),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  indent: 15,
                                  thickness: 2,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          CircularButton(
                            whenPress: () {},
                            title: 'Login With Facebook',
                            buttonColor: Colors.blue,
                            boderColor: Colors.blue,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
