import 'package:flutter/material.dart';
import 'package:food_ordering/screens/sign_in_page.dart';
import 'package:food_ordering/screens/sign_up_page.dart';
import 'package:food_ordering/widgets/circular_button.dart';
class WelcomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black,
              child: Image.asset('images/logo.jpg'),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              //color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Welcome To Tastee",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Column(
                    children: [
                      Text("Oder food form our restaureant and"),
                      Text("make reservations in real-time")
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
             //color: Colors.green,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 CircularButton(
                   whenPress: (){
                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>SignInPage()));
                   },
                   title: 'Login',
                   buttonColor: Theme.of(context).primaryColor,
                   boderColor:Theme.of(context).primaryColor,
                   textColor: Colors.white,
                 ),
                 CircularButton(
                    whenPress: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>SignUpPage()));
                   },
                   title: 'SignUp',
                   textColor: Theme.of(context).primaryColor,
                   buttonColor:Colors.white,
                   boderColor:Theme.of(context).primaryColor,
                 ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
