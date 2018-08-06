import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_edit.dart';
import '../scoped_models/main.dart';



//This is the page where we do generate a list with editable product-items
class ProductListPage extends StatefulWidget {

  final MainModel model;

  ProductListPage(this.model);

  @override
  _ProductListPageState createState() {
    return new _ProductListPageState();
  }

  Widget _buildEditButton(
      BuildContext context, int index, MainModel model) {
    return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          model.selectProduct(model.allProducts[index].id);
          Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return ProductEditPage();
          }));
        });
  }
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    widget.model.fetchProducts();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
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
                  model.selectProduct(model.allProducts[index].id);
                  model.deleteProduct();
                }
              },
              key: Key(index.toString() + model.allProducts[index].title),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      radius: 35.0,
                      backgroundImage: NetworkImage(model.allProducts[index].image),
                    ),
                    title: Text(model.allProducts[index].title),
                    subtitle: Text('\$ ${model.allProducts[index].price}'),
                    trailing: widget._buildEditButton(context, index, model),
                  ),
                  Divider()
                ],
              ),
            );
          },
          itemCount: model.allProducts.length,
        );
      },
    );
  }


}
