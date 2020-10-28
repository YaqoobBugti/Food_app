import 'package:flutter/material.dart';

AppBar appBar({context,@required Function backButtonPress}) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Theme.of(context).accentColor,
    leading: IconButton(
      color: Theme.of(context).primaryColor,
      icon: Icon(
        Icons.arrow_back_ios,
      ),
      onPressed: backButtonPress,
    ),
  );
}
