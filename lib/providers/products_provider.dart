import 'package:flutter/material.dart';
import './product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'T-shirt1',
      description: 'This is a new product',
      price: 9900,
      imageUrl: 'https://cf.shopee.vn/file/799e1ccd3e6158552ee93a05c740da18',
    ),
    Product(
      id: 'p2',
      title: 'T-shirt2',
      description: 'This is a new product',
      price: 9900,
      imageUrl: 'https://cf.shopee.vn/file/799e1ccd3e6158552ee93a05c740da18',
    ),
    Product(
      id: 'p3',
      title: 'T-shirt3',
      description: 'This is a new product',
      price: 9900,
      imageUrl: 'https://cf.shopee.vn/file/799e1ccd3e6158552ee93a05c740da18',
    ),
    Product(
      id: 'p4',
      title: 'T-shirt4',
      description: 'This is a new product',
      price: 9900,
      imageUrl: 'https://cf.shopee.vn/file/799e1ccd3e6158552ee93a05c740da18',
    )
  ];

  var _showFavoritesOnly = false;

  List<Product> get items {
    if (_showFavoritesOnly) {
      return _items.where((prodItem) => prodItem.isFavorite).toList();
    }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findbyId(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct(Product product) {
    final newProduct = Product(
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      id: DateTime.now().toString(),
    );
    _items.add(newProduct);
    //update the list of products
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final productIndex = _items.indexWhere((prod) => prod.id == id);
    if (productIndex >= 0) {
      _items[productIndex] = newProduct;
      notifyListeners();
    } else {
      print('.....');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
