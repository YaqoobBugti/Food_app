import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/modle/cart_modle.dart';
import 'package:food_ordering/modle/more_categories_modle.dart';


class MoreCategoriesProfiver extends ChangeNotifier {
  /////////////// getting burger Categoires/////////////////
  List<MoreCategoriesModle> burgerCategoriesList = [];
  MoreCategoriesModle burgerCategoriesModle;
  Future<void> getBurgerCategories() async {
    List<MoreCategoriesModle> newBurgerCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('moreCategories')
        .doc('to414DcfDNGebplGQqAy')
        .collection('burger')
        .get();
    querySnapshot.docs.forEach(
      (element) {
        burgerCategoriesModle = MoreCategoriesModle(
          image: element.data()['image'],
          name: element.data()['name'],
          price: element.data()['price'],
        );
        newBurgerCategoriesList.add(burgerCategoriesModle);
      },
    );

    burgerCategoriesList = newBurgerCategoriesList;
    notifyListeners();
  }

  get throwBurgerCategoriesList {
    return burgerCategoriesList;
  }

  ///////////////////geting Japanese categories///////////////////

  List<MoreCategoriesModle> japaneseCategoriesList = [];
  MoreCategoriesModle japaneseCategoriesModle;
  Future<void> getJapaneseCategories() async {
    List<MoreCategoriesModle> newJapaneseCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('moreCategories')
        .doc('to414DcfDNGebplGQqAy')
        .collection('japanese')
        .get();
    querySnapshot.docs.forEach(
      (element) {
        japaneseCategoriesModle = MoreCategoriesModle(
          image: element.data()['image'],
          name: element.data()['name'],
          price: element.data()['price'],
        );
        newJapaneseCategoriesList.add(japaneseCategoriesModle);
      },
    );
    japaneseCategoriesList = newJapaneseCategoriesList;
    notifyListeners();
  }

  get throwJapaneseCategoriesList {
    return japaneseCategoriesList;
  }

  //////////////////// geting Noodles Categories///////////////

  List<MoreCategoriesModle> noodlesCategoriesList = [];
  MoreCategoriesModle noodlesCategoriesModle;
  Future<void> getNoodlesCategories() async {
    List<MoreCategoriesModle> newNoodlesCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('moreCategories')
        .doc('to414DcfDNGebplGQqAy')
        .collection('noodles')
        .get();

    querySnapshot.docs.forEach(
      (element) {
        noodlesCategoriesModle = MoreCategoriesModle(
          image: element.data()['image'],
          name: element.data()['name'],
          price: element.data()['price'],
        );
        newNoodlesCategoriesList.add(noodlesCategoriesModle);
      },
    );

    noodlesCategoriesList = newNoodlesCategoriesList;
    notifyListeners();
  }

  get throwNoodlesCategoriesList {
    return noodlesCategoriesList;
  }
  //////////////////// geting Ramen Categories///////////////

  List<MoreCategoriesModle> ramenCategoriesList = [];
  MoreCategoriesModle ramenCategoriesModle;
  Future<void> getRamenCategories() async {
    List<MoreCategoriesModle> newRamenaCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('moreCategories')
        .doc('to414DcfDNGebplGQqAy')
        .collection('ramen')
        .get();
    querySnapshot.docs.forEach(
      (element) {
        ramenCategoriesModle = MoreCategoriesModle(
          image: element.data()['image'],
          name: element.data()['name'],
          price: element.data()['price'],
        );
        newRamenaCategoriesList.add(ramenCategoriesModle);
      },
    );

    ramenCategoriesList = newRamenaCategoriesList;
    notifyListeners();
  }

  get throwRamenCategoriesList {
    return ramenCategoriesList;
  }

  //////////////////// geting SandWiches Categories///////////////
  List<MoreCategoriesModle> sandWichesCategoriesList = [];

  MoreCategoriesModle sandWichesCategoriesModle;
  Future<void> getSandWichesCategories() async {
    List<MoreCategoriesModle> newSandWichesCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('moreCategories')
        .doc('to414DcfDNGebplGQqAy')
        .collection('sandWiches')
        .get();
    querySnapshot.docs.forEach(
      (element) {
        sandWichesCategoriesModle = MoreCategoriesModle(
          image: element.data()['image'],
          name: element.data()['name'],
          price: element.data()['price'],
        );
        newSandWichesCategoriesList.add(sandWichesCategoriesModle);
      },
    );

    sandWichesCategoriesList = newSandWichesCategoriesList;
    notifyListeners();
  }

  get throwSandWichesCategoriesList {
    return sandWichesCategoriesList;
  }

  //////////////add to cart///////////////
  List<CartModle> cartList = [];
  CartModle cartModle;
  List<CartModle> cartNewList = [];
  void addToCart(
      {@required String image,
      @required String name,
      @required int price,
      @required int quantity}) {
    cartModle = CartModle(
      image: image,
      name: name,
      price: price,
      quantity: quantity,
    );
    cartNewList.add(cartModle);
    cartList = cartNewList;
  }

  get throwCartList {
    return cartList;
  }

  int totalAmount() {
    int total = 0;
    cartList.forEach((element) {
      total += element.price * element.quantity;
    });
    return total;
  }

  int myDeleteIndex;
  void getDeleteIndex(int index) {
    myDeleteIndex = index;
  }

  void delete() {
    cartList.removeAt(myDeleteIndex);
    notifyListeners();
  }

  void clean() {
    cartList.clear();
    notifyListeners();
  }

    ////////////////// Notifications ////////////////////
  List<String> notifireList = [];
  void addNotification(String notification) {
    notifireList.add(notification);
  }
  int get getNotificationIndex {
    return notifireList.length;
  }
  
  get getNotificationList {
    return notifireList;
  }
  ///////////////////////   Search   ////////////////////////


  List<MoreCategoriesModle> searchList;
  void getSearchList({List<MoreCategoriesModle> list}) {
    searchList = list;
  }

  List<MoreCategoriesModle> searchCategoryList(String query) {
    List<MoreCategoriesModle> searchShirt = searchList.where(
      (element) {
        return element.name.toUpperCase().contains(query) ||
            element.name.toLowerCase().contains(query) ||
            element.name.toUpperCase().contains(query) &&
                element.name.toLowerCase().contains(query);
      },
    ).toList();
    return searchShirt;
  }
//////////////////////////  End Search  /////////////////////
}
