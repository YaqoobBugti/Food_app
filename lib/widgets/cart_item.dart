import 'package:flutter/material.dart';
import 'package:food_ordering/provider/more_categories_provider.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  final String image;
  final String name;
  final int price;
  final int quantity;
  CartItem({
    this.image,
    this.name,
    this.price,
    this.quantity,
  });
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    MoreCategoriesProfiver moreCategoriesProfiver =
        Provider.of<MoreCategoriesProfiver>(context);
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 3.0,
            color: Colors.grey.withOpacity(0.3),
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.image),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${widget.price * widget.quantity}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Text("x${widget.quantity}")],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              moreCategoriesProfiver.delete();
              setState(() {
                moreCategoriesProfiver.notifireList.clear();
              });
            },
            child: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
