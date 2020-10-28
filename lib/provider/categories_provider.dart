Foodimport 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/modle/categories_modle.dart';

class CategoriesProvider extends ChangeNotifier {
  List<CategoriesModle> burgetItemList = [];
  CategoriesModle burgerItemModle;
  Future<void> getBurgerItem() async {
    List<CategoriesModle> newBurgetItemList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('h8eO7khXIangM13v0IpL')
        .collection('Burder').get();
    querySnapshot.docs.forEach(
      (element) {
        burgerItemModle = CategoriesModle(
          image: element.data()['image'],
          name: element.data()['name'],
        );
        newBurgetItemList.add(burgerItemModle);
      },
    );

    burgetItemList = newBurgetItemList;
    notifyListeners();
  }

  get throwBurgetItem {
    return burgetItemList;
  }

  /////////////////  geted burgetSingle Item ////////////////
  List<CategoriesModle> japaneseItemList = [];
  CategoriesModle japaneseItemModle;
  Future<void> getJapaneseItem() async {
    List<CategoriesModle> newJapaneseModle = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('h8eO7khXIangM13v0IpL')
        .collection('Japanese')
        .get();
    querySnapshot.docs.forEach(
      (element) {
        japaneseItemModle = CategoriesModle(
          image: element.data()['image'],
          name: element.data()['name'],
        );
        newJapaneseModle.add(japaneseItemModle);
      },
    );

    japaneseItemList = newJapaneseModle;
    notifyListeners();
  }

  get throwJapaneseItem {
    return japaneseItemList;
  }

  /////////////////// geted japanese Single Item ////////////

  List<CategoriesModle> noodlesItemList = [];
  CategoriesModle noodlesItemModile;
  Future<void> getNoodlesItem() async {
    List<CategoriesModle> newNoodlesItemList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('h8eO7khXIangM13v0IpL')
        .collection('Noodles')
        .get();
    querySnapshot.docs.forEach(
      (element) {
        noodlesItemModile = CategoriesModle(
          image: element.data()['image'],
          name: element.data()['name'],
        );
        newNoodlesItemList.add(noodlesItemModile);
      },
    );

    noodlesItemList = newNoodlesItemList;
    notifyListeners();
  }

  get throwNoodlesItem {
    return noodlesItemList;
  }
  /////////////////////////// geted noodles Single Item////////////////////////

  List<CategoriesModle> ramenItemList = [];
  CategoriesModle ramenItemModle;
  Future<void> getRamenItem() async {
    List<CategoriesModle> newRamenItemList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc("h8eO7khXIangM13v0IpL")
        .collection('Ramen')
        .get();
    querySnapshot.docs.forEach(
      (element) {
        ramenItemModle = CategoriesModle(
          image: element.data()['image'],
          name: element.data()['name'],
        );

        newRamenItemList.add(ramenItemModle);
      },
    );
    ramenItemList = newRamenItemList;
    notifyListeners();
  }

  get throwRamenItem {
    return ramenItemList;
  }

  //////////////////////// geted SandWiches Single Item//////////////////////
  List<CategoriesModle> sandWichesItemList = [];
  CategoriesModle sandWichesItemModle;
  Future<void> getSandWichesItem() async {
    List<CategoriesModle> newSandWichesModle = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('h8eO7khXIangM13v0IpL')
        .collection('Sandwiches')
        .get();
    querySnapshot.docs.forEach(
      (element) {
        sandWichesItemModle = CategoriesModle(
          image: element.data()['image'],
          name: element.data()['name'],
        );

        newSandWichesModle.add(sandWichesItemModle);
      },
    );
    sandWichesItemList = newSandWichesModle;
    notifyListeners();
  }

  get throwSandWichesItem {
    return sandWichesItemList;
  }
}
