import 'package:flutter/material.dart';
import '../ui_elements/title_default.dart';
import './price_tag.dart';
import '../ui_elements/location_tag.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: <Widget>[
        Image.asset(product['image']),
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
          TitleDefault(product['title']),
          SizedBox(
            width: 20.00,
          ),
          PriceTag(product['price'].toString())
        ],
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
            color: Colors.blueAccent,
            icon: Icon(Icons.info_outline),
            iconSize: 40.00,
            onPressed: () => Navigator.pushNamed<bool>(
                context, '/product/' + productIndex.toString())),
        IconButton(
          color: Colors.pinkAccent,
          icon: Icon(Icons.favorite_border),
          iconSize: 40.00,
          onPressed: () {},
        )
      ],
    );
  }
}
