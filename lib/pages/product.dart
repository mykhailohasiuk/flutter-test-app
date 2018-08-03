import 'package:flutter/material.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/products/price_tag.dart';
import '../widgets/ui_elements/title_default.dart';
import '../widgets/ui_elements/location_tag.dart';
import '../scoped_models/main.dart';
import '../models/product.dart';

class ProductPage extends StatelessWidget {
  final int index;

  ProductPage(this.index);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          final Product product = model.allProducts[index];
          return Scaffold(
              appBar: AppBar(
                title: Text(product.title),
              ),
              body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(product.image),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TitleDefault(product.title),
                          SizedBox(
                            width: 20.00,
                          ),
                          PriceTag(product.price.toString())
                        ],
                      ),
                    ),
                    _buildDescription(product.description),
                    LocationTag(),
                    _buildDeleteButton(context)
                  ]));
        },
      ),
    );
  }

  Widget _buildDescription(String description) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20.00),
        child: Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: IconButton(
          iconSize: 35.0,
          color: Colors.redAccent,
          icon: Icon(Icons.delete_forever),
          onPressed: () => _showWarningDialog(context),
        ));
  }

  void _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('This action can not be udone!!'),
            actions: <Widget>[
              FlatButton(
                child: Text('Continue'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                },
              ),
              FlatButton(
                child: Text("Discard"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
