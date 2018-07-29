import 'package:flutter/material.dart';
import 'dart:async';

import '../widgets/products/price_tag.dart';
import '../widgets/ui_elements/title_default.dart';
import '../widgets/ui_elements/location_tag.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String image;
  final double price;
  final String description;

  ProductPage(this.title, this.image, this.price, this.description);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(image),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TitleDefault(title),
                      SizedBox(
                        width: 20.00,
                      ),
                      PriceTag(price.toString())
                    ],
                  ),
                ),
                _buildDescription(),
                LocationTag(),
                _buildDeleteButton(context)
              ])),
    );
  }

  Widget _buildDescription() {
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
