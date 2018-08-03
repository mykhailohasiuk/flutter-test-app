import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../models/user.dart';

class ConnectedProductsModel extends Model {


  List<Product> _products = [];
  User _authenticatedUser;

  int _selProductIndex;

  void addProduct(
      String title, String description, String image, double price) {
    final Product newProduct = Product(
        title: title,
        description: description,
        price: price,
        image: image,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.id);
    _products.add(newProduct);
    notifyListeners();
  }
}

class ProductsModel extends ConnectedProductsModel {
  bool _showFavorites = false;

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

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

  int get selectedProductIndex {
    return _selProductIndex;
  }

  Product get selectedProduct {
    if (_selProductIndex == null) {
      return null;
    }
    return _products[_selProductIndex];
  }

  void toggleProductFavoriteStatus() {
    final Product selectedProduct = _products[_selProductIndex];
    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;

    final Product updatedProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        isFavorite: newFavoriteStatus,
        userId: selectedProduct.userEmail,
        userEmail: selectedProduct.userId);

    _products[_selProductIndex] = updatedProduct;

    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selProductIndex);
    _selProductIndex = null;
    notifyListeners();
  }

  void updateProduct(
      String title, String description, String image, double price) {
    _products[_selProductIndex] = Product(
        title: title,
        description: description,
        price: price,
        image: image,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    notifyListeners();
  }

  void selectProduct(int index) {
    _selProductIndex = index;
    notifyListeners();
  }
}

class UserModel extends ConnectedProductsModel {

  void login(String email, String password){
    _authenticatedUser = User(
        id: '1234',
        email: email,
        password: password
    );
  }

}
