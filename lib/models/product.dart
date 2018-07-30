import 'package:flutter/material.dart';

class Product {
  final String title;
  final double price;
  final String description;
  final String image;

  Product(
      {@required this.title,
      @required this.description,
      @required this.price,
      @required this.image});
}
