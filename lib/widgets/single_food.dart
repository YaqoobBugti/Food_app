import 'package:flutter/material.dart';

class SingleFood extends StatelessWidget {
  final String image;
  final int price;
  final String name;
  final Function onTap;
  SingleFood(
      {@required this.image,
      @required this.price,
      @required this.name,
      @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.grey[300],
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  '\$ $price',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
