import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final String price;

  PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.5),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.all(Radius.circular(3.0))),
      child: Text(
        '\$ ' + price,
        style: TextStyle(
          fontSize: 20.0,
          fontFamily: 'Oswald',
          color: Colors.white70,
        ),
        textAlign: TextAlign.end,
      ),
    );
  }
}
