import 'package:flutter/material.dart';

import './product_edit.dart';

class ProductListPage extends StatelessWidget {
  final Function updateProduct;
  final List<Map<String, dynamic>> products;

  ProductListPage(this.products, this.updateProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Container(
            width: 70.00,
            height: 70.00,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.00),
              image: DecorationImage(
                  image: ExactAssetImage(products[index]['image']),
                  fit: BoxFit.cover),
            ),
          ),
          title: Text(products[index]['title']),
          trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator
                    .of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return ProductEditPage(
                    product: products[index],
                    updateProduct: updateProduct,
                    productIndex: index,
                  );
                }));
              }),
        );
      },
      itemCount: products.length,
    );
  }
}
