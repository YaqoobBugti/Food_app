import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_ordering/screens/sign_in_page.dart';
import 'package:food_ordering/screens/welcome_page.dart';
import 'package:food_ordering/widgets/app_bar.dart';
import 'package:food_ordering/widgets/circular_button.dart';
import 'package:food_ordering/widgets/my_text_field.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  UserCredential authResult;
  File image;
  var _uploadeImageURL;
  var uid;
  bool loading = false;
  RegExp regExp = RegExp(SignUpPage.pattern);

  ////////////////Email regExp patterns///////

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();

  Future pickImage({@required ImageSource imageSource}) async {
    final getimage = await ImagePicker().getImage(source: imageSource);
    setState(
      () {
        image = File(getimage.path);
      },
    );
    Navigator.of(context).pop();
  }

  Widget snackbar({@required String massage}) {
    return SnackBar(
      content: Text(massage),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  void userUid() async {
    User user = FirebaseAuth.instance.currentUser;
    uid = user.uid;
  }

  Future uploadImage() async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('userImages/$uid}');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then(
      (fileURL) {
        setState(
          () {
              _uploadeImageURL = fileURL;
          },
        );
      },
    );
  }
     
  validationFunction() {
    if (firstName.text.trim().isEmpty &&
        lastName.text.trim().isEmpty &&
        emailAddress.text.trim().isEmpty &&
        password.text.trim().isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        snackbar(massage: 'All Is Empty'),
      );
      return;
    }
    if (firstName.text.trim().isEmpty || firstName.text == null) {
      _scaffoldKey.currentState.showSnackBar(
        snackbar(massage: 'First Name Is Empty'),
      );
      return;
    }
    if (lastName.text.trim().isEmpty || lastName.text.trim() == null) {
      _scaffoldKey.currentState.showSnackBar(
        snackbar(massage: 'lastName is Empty'),
      );
      return;
    }
    if (emailAddress.text.trim().isEmpty || emailAddress.text.trim() == null) {
      _scaffoldKey.currentState.showSnackBar(
        snackbar(massage: 'emailAddress is Empty'),
      );
      return;
    } else if (!regExp.hasMatch(emailAddress.text.trim())) {
      _scaffoldKey.currentState.showSnackBar(
        snackbar(massage: 'invaild Email Address'),
      );
      return;
    }
    if (password.text.trim().isEmpty || password.text == null) {
      _scaffoldKey.currentState.showSnackBar(
        snackbar(massage: 'password is Empty'),
      );
      return;
    } else if (password.text.length <= 8) {
      _scaffoldKey.currentState.showSnackBar(
        snackbar(massage: 'passwrod must be Eight'),
      );
      return;
    }
    if (image == null || image.path.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        snackbar(massage: 'Image is empty'),
      );
      return;
    } else {
      sendData();
      uploadImage();
    }
  }

  Future sendData() async {
    try {
      setState(() {
        loading = true;
      });
      authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress.text,
        password: password.text,
      );

      await FirebaseFirestore.instance
          .collection('user')
          .doc(authResult.user.uid)
          .set(
        {
          'firstName': firstName.text,
          'lastName': lastName.text,
          'emailAddress': emailAddress.text,
          'password': password.text,
          // 'userImage': _uploadeImageURL==null?:_uploadeImageURL,
          'userUid': authResult.user.uid,
        },
      );
    } on PlatformException catch (err) {
      var massage = "An error occurred ,please check your credentials";
      if (err.message != null) {
        massage = err.message;
      }
      _scaffoldKey.currentState.showSnackBar(
        snackbar(
          massage: massage,
        ),
      );
      setState(() {
        loading = false;
      });
    }
    setState(() {
      loading = false;
    });
  }

  Future<void> aleart() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Choose an action'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  onTap: () {
                    pickImage(imageSource: ImageSource.gallery);
                  },
                  child: Text("Gallery"),
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  onTap: () {
                    pickImage(imageSource: ImageSource.camera);
                  },
                  child: Text("Camera"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    userUid();
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
          context: context),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              "Create new account",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundImage: image == null
                      ? AssetImage("images/nonprofile.jpg")
                      : FileImage(image),
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.blue[50],
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      size: 20,
                    ),
                    onPressed: () {
                      aleart();
                    },
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                //color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        MyTextField(
                          textEditingController: firstName,
                          hintText: "First name",
                          forgetPassword: '',
                          obscureText: false,
                          textInputType: TextInputType.name,
                        ),
                        MyTextField(
                          textEditingController: lastName,
                          forgetPassword: '',
                          hintText: 'last name',
                          obscureText: false,
                          textInputType: TextInputType.name,
                        ),
                        MyTextField(
                          textEditingController: emailAddress,
                          hintText: "E-mail Address",
                          forgetPassword: '',
                          obscureText: false,
                          textInputType: TextInputType.emailAddress,
                        ),
                        MyTextField(
                          textEditingController: password,
                          hintText: "Password",
                          forgetPassword: '',
                          obscureText: true,
                          textInputType: TextInputType.visiblePassword,
                        ),
                      ],
                    ),
                    Container(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (loading)
                            CircularProgressIndicator(
                              backgroundColor: Colors.blue,
                            ),
                          if (!loading)
                            CircularButton(
                              whenPress: () {
                                validationFunction();
                              },
                              title: "Sign Up",
                              buttonColor: Theme.of(context).primaryColor,
                              boderColor: Theme.of(context).primaryColor,
                              textColor: Colors.white,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => SignInPage()));
                                },
                                child: Text(
                                  "Log In",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
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
