import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(
  //   this.title,
  //   this.price,
  // );
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadProduct = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).findbyId(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadProduct.title),
      ),
    );
  }
}