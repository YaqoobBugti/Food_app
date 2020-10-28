import 'package:flutter/material.dart';
import 'package:food_ordering/modle/single_food_modle.dart';
import 'package:food_ordering/provider/myProvider.dart';
import 'package:food_ordering/screens/detail_page.dart';
import 'package:food_ordering/widgets/single_food.dart';
import 'package:provider/provider.dart';

class Search extends SearchDelegate<SingleFoodModle> {
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
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    List<SingleFoodModle> _searchfoodList = provider.search(query);

    return ListView(
        children: _searchfoodList
            .map<Widget>(
              (e) => SingleFood(
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
              ),
            )
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    List<SingleFoodModle> _searchfoodList = provider.search(query);
    return ListView(
        children: _searchfoodList
            .map(
              (e) => SingleFood(
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
                name: e.name,
                price: e.price,
              ),
            )
            .toList());
  }
}
