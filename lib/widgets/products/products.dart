import 'package:flutter/material.dart';

import './product_card.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products(this.products);

  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }

  Widget _buildProductList() {
    Widget productCards;
    if (products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index], index),
        itemCount: products.length,
      );
    } else {
      productCards = Container(
        child: Text('No Items Found. Pleas ad some in the admin section'),
      );
    }

    return productCards;
  }
}
