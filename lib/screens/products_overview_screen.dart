import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';

class ProductsOverviewScreen extends StatelessWidget {
  final List<Product> loadProduct = [
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: loadProduct.length,
        itemBuilder: (ctx, index) => ProductItem(
          loadProduct[index].id,
          loadProduct[index].title,
          loadProduct[index].imageUrl,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
