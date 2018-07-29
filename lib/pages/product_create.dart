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
  final Map<String, dynamic> _formData = {
    'title': '',
    'description': '',
    'price': 0.0,
    'image': 'assets/food.jpg'
  };

  String _titleValue = '';
  String _descriptionValue = '';
  double _priceValue = 0.00;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double targetWith = deviceWidth > 700.0 ? 500.0 : deviceWidth * 0.95;
    double targetPadding = (deviceWidth - targetWith) / 2;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding),
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
        ),
      ),
    );
  }

//  Custom Widget build Methods

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product Title: ',
      ),
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'Title is required and should be 5+ chars long';
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildTitlePriceField() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price should be numerical!';
        }
      },
      decoration: InputDecoration(
        labelText: 'Product Price: ',
      ),
      keyboardType:
          TextInputType.numberWithOptions(signed: false, decimal: true),
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
    );
  }

  Widget _buildTitleDecorationField() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
          return 'Description is required and should be 10+ chars long';
        }
      },
      decoration: InputDecoration(
        labelText: 'Product Description: ',
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.addProduct(_formData);
      Navigator.pushReplacementNamed(context, '/products');
    } else
      return;
  }
}
