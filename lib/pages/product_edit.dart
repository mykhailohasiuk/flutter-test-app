import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';

import '../widgets/helpers/ensure-visible.dart';

class ProductEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': '',
    'description': '',
    'price': 0.0,
    'image': 'assets/food.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      final Widget pageContent =
          _buildEditPageContent(context, model.selectedProduct);
      return model.selectedProductIndex == null
          ? pageContent
          : Scaffold(
              appBar: AppBar(
                title: Text('Edit Item'),
              ),
              body: pageContent,
            );
    });
  }

  Widget _buildEditPageContent(BuildContext context, Product product) {
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
              _buildTitleTextField(product),
              _buildPriceField(product),
              _buildDescriptionField(product),
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: _buildSubmitButton(),
              )
            ],
          ),
        ),
      ),
    );
  }

//  Custom Widget build Methods

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RaisedButton(
          child: Text('Save'),
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
          onPressed: () => _submitForm(model.addProduct, model.updateProduct,
              model.selectProduct, model.selectedProductIndex),
        );
      },
    );
  }

  Widget _buildTitleTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        initialValue: product == null ? '' : product.title,
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
      ),
    );
  }

  Widget _buildPriceField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        initialValue: product == null ? '' : product.price.toString(),
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
      ),
    );
  }

  Widget _buildDescriptionField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        initialValue: product == null ? '' : product.description,
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
      ),
    );
  }

  void _submitForm(
      Function addProduct, Function updateProduct, Function setSelectedProduct,
      [int selectedProductIndex]) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      if (selectedProductIndex == null) {
        addProduct(_formData['title'], _formData['description'],
            _formData['image'], _formData['price']);
      } else {
        updateProduct(_formData['title'], _formData['description'],
            _formData['image'], _formData['price']);
      }
      Navigator
          .pushReplacementNamed(context, '/products')
          .then((_) => setSelectedProduct(null));
    } else
      return;
  }
}
