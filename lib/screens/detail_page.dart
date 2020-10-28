import 'package:flutter/material.dart';
import 'package:food_ordering/provider/more_categories_provider.dart';
import 'package:food_ordering/screens/cart_page.dart';

import 'package:food_ordering/screens/home_page.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String image;
  final int price;
  final String name;
  DetailPage({@required this.image, @required this.price, @required this.name});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    MoreCategoriesProfiver moreCategoriesProfiver =
        Provider.of<MoreCategoriesProfiver>(context);
        
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35),
        child: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black54,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          elevation: 0.0,
          backgroundColor: Colors.grey[200],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100.0),
                  ),
                ),
                child: Center(
                  child: Material(
                    elevation: 3.1,
                    shadowColor: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.image),
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ListTile(
                      leading: Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      trailing: Text(
                        "\$ ${widget.price * count}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          child: RaisedButton(
                            elevation: 1.1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              setState(() {
                                if (count > 1) count--;
                              });
                            },
                            child: Text("-"),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(count.toString()),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 40,
                          child: RaisedButton(
                            elevation: 1.1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              setState(() {
                                count++;
                              });
                            },
                            child: Text("+"),
                          ),
                        ),
                      ],
                    ),
                    Text(
                        "products, kitchen, or any other sort of eCommerce shop. The theme is clean, minimal and responsive, it's flat design with a few shadows here and there to make some elements stand out. We have given the theme great page speed / load time and made it fully SEO optimized. Due to the new editor it's a multi-purpose theme as well, you have the option to make any sort of business page or blog. You can use the one-click checkout feature to make your store an Amazon affiliate store as well easily. It works on every screen size and device, we have made sure your new store looks amazing everywhere"),
                    Container(
                      height: 55,
                      width: double.infinity,
                      child: RaisedButton(
                        elevation: 1.0,
                        color: Colors.blueGrey[50].withOpacity(0.9),
                        child: Text(
                          "Send To Cart",
                          style: TextStyle(
                            color: Colors.black87.withOpacity(0.5),
                            fontSize: 25,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        textColor: Colors.indigo[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          moreCategoriesProfiver.addNotification('Item');
                          moreCategoriesProfiver.addToCart(
                            image: widget.image,
                            name: widget.name,
                            price: widget.price,
                            quantity: count,
                          );
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => CartPage(),
                            ),
                          );
                        },
                      ),
                    )
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
