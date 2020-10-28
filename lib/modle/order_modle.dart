import 'package:flutter/cupertino.dart';
import 'package:food_ordering/modle/cart_modle.dart';

class OrderModle {
  final String id;
  final int price;
  final List<CartModle> cartList;
  final DateTime time;
  OrderModle({
    @required this.id,
    @required this.price,
    @required this.cartList,
    @required this.time,
  });
}
