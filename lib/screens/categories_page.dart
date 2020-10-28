import 'package:flutter/material.dart';
import 'package:food_ordering/modle/more_categories_modle.dart';
import 'package:food_ordering/provider/more_categories_provider.dart';
import 'package:food_ordering/screens/categories_search.dart';
import 'package:food_ordering/screens/detail_page.dart';
import 'package:food_ordering/screens/home_page.dart';

import 'package:food_ordering/widgets/single_food.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatelessWidget {
  List<MoreCategoriesModle> list = [];
  CategoriesPage({@required this.list});
  @override
  Widget build(BuildContext context) {
    MoreCategoriesProfiver more_categories_provider=Provider.of<MoreCategoriesProfiver>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color:Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
            onPressed: () {
              more_categories_provider.getSearchList(
                list: list,
              );
              showSearch(
                context: context,
                delegate: CategoriesSearch(),
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: GridView.count(
          crossAxisCount: 1,
          childAspectRatio: 1.2,
          children: list
              .map(
                (e) => Container(
                  child: SingleFood(
                    image: e.image,
                    name: e.name,
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            image: e.image,
                            price: e.price,
                            name: e.name,
                          ),
                        ),
                      );
                    },
                    price: e.price,
                  ),
                ),
              )
              .toList()),
    );
  }
}
