import 'package:flutter/material.dart';
import '../models/product.dart';

import './product_edit.dart';

class ProductListPage extends StatelessWidget {
  final Function updateProduct;
  final Function deleteProduct;

  final List<Product> products;

  ProductListPage(this.products, this.updateProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          background: Container(
            color: Colors.redAccent,
            child: Center(
              child: Text(
                'DELETE ITEM',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Oswald',
                    letterSpacing: 4.00,
                    fontSize: 23.0),
              ),
            ),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              deleteProduct(index);
            }
          },
          key: Key(index.toString() + products[index].title),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  radius: 35.0,
                  backgroundImage: AssetImage(products[index].image),
                ),
                title: Text(products[index].title),
                subtitle: Text('\$ ${products[index].price}'),
                trailing: _buildEditButton(context, index),
              ),
              Divider()
            ],
          ),
        );
      },
      itemCount: products.length,
    );
  }

  Widget _buildEditButton(BuildContext context, int index) {
    return IconButton(
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
        });
  }
}
