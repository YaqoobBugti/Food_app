import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/modle/user_modle.dart';
import 'package:food_ordering/screens/home_page.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final UserModle currentUsers;

  ProfilePage({@required this.currentUsers});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var imageMap;
  RegExp regex = RegExp(ProfilePage.pattern);

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool edit = false;
  var uid;
  File image;
  TextEditingController firstName;
  TextEditingController lastName;
  TextEditingController emailAddress;
  TextEditingController password;

  Future<String> uploadImage(File _image) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('userImages/$uid}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    StorageTaskSnapshot task = await uploadTask.onComplete;
    final String _imageUrl = await task.ref.getDownloadURL();
    return _imageUrl;
  }

  Future pickedImage(ImageSource imageSource) async {
    final getImage = await ImagePicker().getImage(source: imageSource);
    setState(() {
      image = File(getImage.path);
    });
    Navigator.of(context).pop();
  }

  Future<void> alart(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Choose an action"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      pickedImage(ImageSource.gallery);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      pickedImage(ImageSource.camera);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  void userDataUpdate() async {
    image != null ? imageMap = await uploadImage(image) : Container();
    await FirebaseFirestore.instance.collection("user").doc(uid).update({
      "firstName": firstName.text,
      "lastName": lastName.text,
      "emailAddress": emailAddress.text,
      "password": password.text,
      "userImage": image == null ? widget.currentUsers.userImage : imageMap,
    });
  }

  Widget textForm({@required TextEditingController controller}) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.blueGrey[50].withOpacity(0.9),
          filled: true,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.indigo[300],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget filledContainer({@required String name}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[50].withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 65,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 22, left: 20),
        child: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.indigo[300],
          ),
        ),
      ),
    );
  }

  void currentUserFunction() async {
    User user = FirebaseAuth.instance.currentUser;
    uid = user.uid;
  }

  validation() {
    if (firstName.text.isEmpty &&
        lastName.text.isEmpty &&
        emailAddress.text.isEmpty &&
        password.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
            content: Text('All field is emtpy'),
            backgroundColor: Theme.of(context).primaryColor),
      );
      return;
    }
    if (firstName.text.trim().isEmpty || firstName.text.trim() == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
            content: Text(
              'firstName is empty',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            backgroundColor: Theme.of(context).primaryColor),
      );
      return;
    }
    if (lastName.text.trim().isEmpty || lastName.text.trim() == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
            content: Text(
              'lastName is empty',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            backgroundColor: Theme.of(context).primaryColor),
      );
      return;
    }
    if (emailAddress.text.trim().isEmpty || emailAddress.text.trim() == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
            content: Text('emailAddress is empty'),
            backgroundColor: Theme.of(context).primaryColor),
      );
      return;
    } else if (!regex.hasMatch(emailAddress.text)) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
            content: Text('Please Enter Valid Email'),
            backgroundColor: Theme.of(context).primaryColor),
      );
      return;
    } else {
      setState(() {
        edit = false;
        userDataUpdate();
        uploadImage(image);
      });
    }
  }

  @override
  void initState() {
    firstName = TextEditingController(text: widget.currentUsers.firstName);
    lastName = TextEditingController(text: widget.currentUsers.lastName);
    emailAddress =
        TextEditingController(text: widget.currentUsers.emailAddress);
    password = TextEditingController(text: widget.currentUsers.passwrod);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentUserFunction();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).accentColor,
        leading: edit
            ? IconButton(
                icon: Icon(Icons.close),
                color: Colors.blueGrey,
                onPressed: () {
                  setState(() {
                    edit = false;
                  });
                },
              )
            : IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black54,
                ),
                onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>HomePage()));
                },
                // onPressed: () {
                //   Navigator.of(context).pushReplacement(
                //       MaterialPageRoute(builder: (context) => HomePage()));
                // },
              ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.blueGrey,
            ),
            onPressed: () {
              setState(() {
                edit = true;
              });
            },
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 230,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: image == null
                              ? widget.currentUsers.userImage == null
                                  ? AssetImage('images/profile.jpg')
                                  : NetworkImage(widget.currentUsers.userImage)
                              : FileImage(image),
                        ),
                        edit
                            ? Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 17,
                                ),
                                child: CircleAvatar(
                                  radius: 17,
                                  backgroundColor: Colors.blueGrey,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      alart(context);
                                    },
                                  ),
                                ),
                              )
                            : Text("")
                      ],
                    ),
                    Text(
                      widget.currentUsers.firstName,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            edit
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 400,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          textForm(
                            controller: firstName,
                          ),
                          textForm(
                            controller: lastName,
                          ),
                          textForm(
                            controller: emailAddress,
                          ),
                          textForm(controller: password),
                          Container(
                            height: 64,
                            width: double.infinity,
                            child: RaisedButton(
                              elevation: 1.0,
                              color: Colors.blueGrey[50].withOpacity(0.9),
                              child: Text(
                                "Update",
                                style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              textColor: Colors.indigo[300],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0)),
                              onPressed: () {
                                validation();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 400,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          filledContainer(
                            name: widget.currentUsers.firstName,
                          ),
                          filledContainer(
                            name: widget.currentUsers.lastName,
                          ),
                          filledContainer(
                            name: widget.currentUsers.emailAddress,
                          ),
                          filledContainer(
                            name: widget.currentUsers.passwrod,
                          ),
                        ],
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
