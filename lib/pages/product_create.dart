import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String _titleValue = '';
  String _descriptionValue = '';
  double _priceValue = 0.00;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: ListView(
        children: <Widget>[
          _buildTitleTextField(),
          _buildTitlePriceField(),
          _buildTitleDecorationField(),
          Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: RaisedButton(
              child: Text('Save'),
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              onPressed: _submitForm,
            ),
          )
        ],
      ),
    );
  }

//  Custom Widget build Methods

  Widget _buildTitleTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Product Title: ',
      ),
      onChanged: (String value) {
        setState(() {
          _titleValue = value;
        });
      },
    );
  }

  Widget _buildTitlePriceField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Product Price: ',
      ),
      keyboardType:
          TextInputType.numberWithOptions(signed: false, decimal: true),
      onChanged: (String value) {
        setState(() {
          _priceValue = double.parse(value);
        });
      },
    );
  }

  Widget _buildTitleDecorationField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Product Description: ',
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      onChanged: (String value) {
        setState(() {
          _descriptionValue = value;
        });
      },
    );
  }

  void _submitForm() {
    final Map<String, dynamic> product = {
      'title': _titleValue,
      'description': _descriptionValue,
      'price': _priceValue,
      'image': 'assets/food.jpg'
    };
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }
}
