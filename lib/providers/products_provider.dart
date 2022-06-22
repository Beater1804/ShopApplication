import 'package:flutter/material.dart';
import '../models/product.dart';

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

  List<Product> get items {
    return [..._items];
  }

  Product findbyId(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProduct() {
    // _items.add(value);
    //update the list of products
    notifyListeners();
  }
}
