import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/modle/cart_modle.dart';
import 'package:food_ordering/modle/order_modle.dart';
import 'package:food_ordering/modle/single_food_modle.dart';
import 'package:food_ordering/modle/user_modle.dart';

class MyProvider extends ChangeNotifier {
////////////////////  Get User Data ///////////////////////////////
  User currentUser = FirebaseAuth.instance.currentUser;
  UserModle userModle;
  
  Future<void> getUserData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('user').get();
    querySnapshot.docs.forEach(
      (element) {
        if (currentUser.uid == element.data()['userUid']) {
          userModle = UserModle(
            userImage: element.data()['userImage'],
            firstName: element.data()['firstName'],
            lastName: element.data()['lastName'],
            emailAddress: element.data()['emailAddress'],
            passwrod: element.data()['password'],
          );
        }
      },
    );
    notifyListeners();
  }

  get throwUserData {
    return userModle == null
        ? UserModle(
            emailAddress: '',
            firstName: '',
            lastName: '',
            userImage:
                'https://d33v4339jhl8k0.cloudfront.net/docs/assets/528e78fee4b0865bc066be5a/images/52af1e8ce4b074ab9e98f0e0/file-mxuiNezRS5.jpg',
            passwrod: '')
        : userModle;
  }
  //////////////////  get user data is end ///////////////

  ///////////////GET SIGNLE FOOD ///////////////////////////

  List<SingleFoodModle> singleFoodList = [];
  SingleFoodModle singleFoodModle;
  Future<void> getSingleFood() async {
    List<SingleFoodModle> newSingleFoodList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('singleFood').get();
    querySnapshot.docs.forEach(
      (element) {
        singleFoodModle = SingleFoodModle(
          name: element.data()['name'],
          image: element.data()['image'],
          price: element.data()['price'],
        );
        newSingleFoodList.add(singleFoodModle);
      },
    );

    singleFoodList = newSingleFoodList;
    notifyListeners();
  }

  get throwSingleFoodList {
    return singleFoodList;
  }


  ///////////////odder/////////////////////
  List<OrderModle> _order = [];
  List<OrderModle> get order {
    return [..._order];
  }

  Future<void> sendOrder({
    @required List<CartModle> cartModle,
    int totalPrice,
  }) async {
    final timestamp = DateTime.now();
    try {
      FirebaseFirestore.instance.collection('userOrder').add({
        'orderName': userModle.lastName,
        'OrderLast': userModle.lastName,
        'orderEmail': userModle.emailAddress,
        'orderImage': userModle.userImage,
        'orderId': DateTime.now().toString(),
        'orderTotalPrice': totalPrice,
        'orderTimeDate': timestamp.toIso8601String(),
        'orderProduct': cartModle
            .map((e) => {
                  'orderImage': e.image,
                  'orderName': e.name,
                  'orderprice': e.price,
                  'orderQueantity': e.quantity,
                })
            .toList(),
      });
      _order.insert(
        0,
        OrderModle(
          id: DateTime.now().toString(),
          price: totalPrice,
          cartList: cartModle,
          time: timestamp,
        ),
      );
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
//////////////////////////////search ////////////////////
  List<SingleFoodModle> search(String query) {
    List<SingleFoodModle> searchList = singleFoodList.where((element) {
      return element.name.toUpperCase().contains(query) ||
             element.name.toLowerCase().contains(query) ||
             element.name.toUpperCase().contains(query) &&
            element.name.toLowerCase().contains(query);
             }).toList();
    return searchList;
  }
  //////////////////////// search////////////////////////////////
}
