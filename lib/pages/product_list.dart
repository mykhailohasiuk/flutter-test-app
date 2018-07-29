import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;


  ProductListPage(this.products);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Product List'),
    );
  }
}
