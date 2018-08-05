import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product.dart';
import '../models/user.dart';

class ConnectedProductsModel extends Model {
  List<Product> _products = [];
  User _authenticatedUser;
  bool _isLoading = false;
  String _selProductId;
}

class ProductsModel extends ConnectedProductsModel {
  bool _showFavorites = false;

//  GETTER FUNCTIONS

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return List.from(
          _products.where((Product product) => product.isFavorite).toList());
    }
    return List.from(_products);
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  String get selectedProductId {
    return _selProductId;
  }

  int get selProductIndex {
    return _products.indexWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  Product get selectedProduct {
    if (_selProductId == null) {
      return null;
    }
    return _products.firstWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  //CRUD FUNCTIONS

  Future<bool> addProduct(
      String title, String description, String image, double price) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://insidefmcg.com.au/wp-content/uploads/2017/04/chocolate3.jpg',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };
    try {
      final http.Response response = await http.post(
          'https://flutter-tut-app.firebaseio.com/products.json',
          body: json.encode(productData));
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Product newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          price: price,
          image:
              'https://insidefmcg.com.au/wp-content/uploads/2017/04/chocolate3.jpg',
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _products.add(newProduct);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<Null> fetchProducts() {
    _isLoading = true;
    notifyListeners();
    return http
        .get('https://flutter-tut-app.firebaseio.com/products.json')
        .then<Null>((http.Response response) {
      final List<Product> fetchedProductList = [];

      final Map<String, dynamic> productListData = json.decode(response.body);
      if (productListData != null) {
        productListData.forEach((String id, dynamic productData) {
          final Product product = Product(
              id: id,
              title: productData['title'],
              description: productData['description'],
              price: productData['price'],
              image: productData['image'],
              userEmail: productData['userEmail'],
              userId: productData['userId']);
          fetchedProductList.add(product);
        });
      }
      _products = fetchedProductList;
      _isLoading = false;
      notifyListeners();
      _selProductId = null;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  Future<bool> deleteProduct() {
    _isLoading = true;
    notifyListeners();
    final String deletedProductId = selectedProduct.id;
    _products.removeAt(selProductIndex);
    _selProductId = null;
    return http
        .delete(
            'https://flutter-tut-app.firebaseio.com/products/$deletedProductId.json')
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> updateProduct(
      String title, String description, String image, double price) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updatedData = {
      'title': title,
      'description': description,
      'image':
          'https://insidefmcg.com.au/wp-content/uploads/2017/04/chocolate3.jpg',
      'price': price,
      'userEmail': selectedProduct.userEmail,
      'userId': selectedProduct.userId
    };

    return http
        .put(
            'https://flutter-tut-app.firebaseio.com/products/${selectedProduct
            .id}.json',
            body: json.encode(updatedData))
        .then((http.Response response) {
      _products[selProductIndex] = Product(
          id: selectedProduct.id,
          title: title,
          description: description,
          price: price,
          image: image,
          userEmail: selectedProduct.userEmail,
          userId: selectedProduct.userId);
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

//OTHERS: FAVORITE, DISPLAY, SELECTION

  void toggleProductFavoriteStatus() {
    final Product selectedProduct = _products[selProductIndex];
    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;

    final Product updatedProduct = Product(
        id: selectedProduct.id,
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        isFavorite: newFavoriteStatus,
        userId: selectedProduct.userEmail,
        userEmail: selectedProduct.userId);

    _products[selProductIndex] = updatedProduct;

    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

  void selectProduct(String productId) {
    _selProductId = productId;
    notifyListeners();
  }
}

class UserModel extends ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User(id: '1234', email: email, password: password);
  }
}

class UtilityModel extends ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
