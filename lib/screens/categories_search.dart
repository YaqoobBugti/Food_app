import 'package:flutter/material.dart';
import 'package:food_ordering/modle/more_categories_modle.dart';
import 'package:food_ordering/provider/more_categories_provider.dart';
import 'package:food_ordering/screens/detail_page.dart';
import 'package:food_ordering/widgets/single_food.dart';
import 'package:provider/provider.dart';

class CategoriesSearch extends SearchDelegate<MoreCategoriesModle> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    MoreCategoriesProfiver provider =
        Provider.of<MoreCategoriesProfiver>(context, listen: false);
    List<MoreCategoriesModle> _searchfoodList =
        provider.searchCategoryList(query);

    return ListView(
        children: _searchfoodList.map<Widget>(
      (e) {
        return SingleFood(
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
          image: e.image,
          price: e.price,
          name: e.name,
        );
      },
    ).toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    MoreCategoriesProfiver provider =
        Provider.of<MoreCategoriesProfiver>(context, listen: false);
    List<MoreCategoriesModle> _searchfoodList =
        provider.searchCategoryList(query);

    return ListView(
        children: _searchfoodList.map<Widget>(
      (e) {
        return SingleFood(
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
          image: e.image,
          price: e.price,
          name: e.name,
        );
      },
    ).toList());
  }
}
