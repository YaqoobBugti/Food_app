import 'package:flutter/material.dart';
import 'package:food_ordering/provider/more_categories_provider.dart';
import 'package:food_ordering/provider/myProvider.dart';
import 'package:food_ordering/screens/home_page.dart';
import 'package:food_ordering/widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}
class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    MoreCategoriesProfiver moreCategoriesProfiver =
        Provider.of<MoreCategoriesProfiver>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
        actions: [
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total price",
                    style: TextStyle(fontSize: 19),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "\$${moreCategoriesProfiver.totalAmount()}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  )
                ],
              ),
              Builder(builder: (ctx) {
                return Container(
                  height: 45,
                  width: 150,
                  child: RaisedButton(
                    child: Text(
                      "Send Food",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                    color: Colors.lightBlue[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: moreCategoriesProfiver.totalAmount() <= 0
                        ? null
                        : () async {
                            await Provider.of<MyProvider>(context,
                                    listen: false)
                                .sendOrder(
                              cartModle:
                                  moreCategoriesProfiver.cartList.toList(),
                              totalPrice: moreCategoriesProfiver.totalAmount(),
                            );

                            Scaffold.of(ctx).showSnackBar(
                              SnackBar(
                                content: Text('Send Your Orders'),
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            );
                            moreCategoriesProfiver.clean();
                          },
                  ),
                );
              })
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView.builder(
            itemCount: moreCategoriesProfiver.throwCartList.length,
            itemBuilder: (context, index) {
              moreCategoriesProfiver.getDeleteIndex(index);
              return CartItem(
                image: moreCategoriesProfiver.cartList[index].image,
                name: moreCategoriesProfiver.cartList[index].name,
                price: moreCategoriesProfiver.cartList[index].price,
                quantity: moreCategoriesProfiver.cartList[index].quantity,
              );
            },
          ),
        ),
      ),
    );
  }
}
