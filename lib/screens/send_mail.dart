import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_ordering/modle/user_modle.dart';
import 'package:food_ordering/provider/myProvider.dart';
import 'package:food_ordering/screens/home_page.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';

class SendMail extends StatefulWidget {
  @override
  _SendMailState createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  UserModle userModle;
  var uid;
  UserCredential authResult;
  TextEditingController sendMail = TextEditingController();
  void userUid() async {
    User user = FirebaseAuth.instance.currentUser;
    uid = user.uid;
  }

  Future mailFuction() async {
    try {
      await FirebaseFirestore.instance.collection('sendMail').doc().set(
        {
          'firstName': userModle.firstName,
          'lastName': userModle.lastName,
          'emailAddress': userModle.emailAddress,
          'Massage Mail': sendMail.text,
        },
      );
    } on PlatformException catch (err) {
      var massage = "An error occurred ,please check your credentials";
      if (err.message != null) {
        massage = err.message;
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(massage),
          backgroundColor: Theme.of(context).primaryColor,
        ));
      }
    }
  }

  Widget fillContaienr({@required String name}) {
    return Container(
      height: 58,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueGrey[50].withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 17, left: 20),
        child: Text(
         name,
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    userUid();
    MyProvider myProvider = Provider.of<MyProvider>(context);
    myProvider.getUserData();
    userModle = myProvider.throwUserData;
    return KeyboardDismisser(
      gestures: [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
             
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          centerTitle: true,
          title: Text("Send Mail",style: TextStyle(color: Colors.blueGrey)),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 130),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[500],
                        offset: Offset(4.0, 4.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4.0, -4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          fillContaienr(
                            name: userModle.firstName
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          fillContaienr(
                            name: userModle.emailAddress
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: sendMail,
                            maxLines: 10,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blueGrey[50].withOpacity(0.9),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          )
                        ],
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.blueGrey,
                        onPressed: () {
                          mailFuction();
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
