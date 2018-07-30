import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


import './product_edit.dart';
import '../scoped_models/products.dart';

class ProductListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
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
                  model.selectProduct(index);
                  model.deleteProduct();
                }
              },
              key: Key(index.toString() + model.products[index].title),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      radius: 35.0,
                      backgroundImage: AssetImage(model.products[index].image),
                    ),
                    title: Text(model.products[index].title),
                    subtitle: Text('\$ ${model.products[index].price}'),
                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider()
                ],
              ),
            );
          },
          itemCount: model.products.length,
        );
      },
    );
  }

  Widget _buildEditButton(BuildContext context, int index, ProductsModel model) {

        return IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              model.selectProduct(index);
              Navigator
                  .of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return ProductEditPage();
              }));
            });
      }
}
