import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped_models/main.dart';
import '../../models/product.dart';
import '../ui_elements/title_default.dart';
import './price_tag.dart';
import '../ui_elements/location_tag.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: <Widget>[
        FadeInImage(
          image: NetworkImage(product.image),
          placeholder: AssetImage('assets/food.jpg'),
          height: 300.0,
          fit: BoxFit.cover,
        ),
        _buildCardHeader(),
        LocationTag(),
        _buildBottomButtons(context)
      ]),
    );
  }

  Widget _buildCardHeader() {
    return Container(
      padding: const EdgeInsets.all(8.0),
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
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ButtonBar(alignment: MainAxisAlignment.center, children: <Widget>[
        IconButton(
            color: Colors.blueAccent,
            icon: Icon(Icons.info_outline),
            iconSize: 40.00,
            onPressed: () => Navigator.pushNamed<bool>(
                context, '/product/' + model.allProducts[productIndex].id)),
        Column(
          children: <Widget>[
            IconButton(
              color: Colors.pinkAccent,
              icon: Icon(model.allProducts[productIndex].isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
              iconSize: 40.00,
              onPressed: () {
                model.selectProduct(model.allProducts[productIndex].id);
                model.toggleProductFavoriteStatus();
              },
            )
          ],
        ),
      ]);
    });
  }
}
