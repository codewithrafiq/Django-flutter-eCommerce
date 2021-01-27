import 'package:flutter/material.dart';
import 'package:flutterd/state/product_state.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreens extends StatelessWidget {
  static const routeName = '/product-details-screens';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final product = Provider.of<ProductState>(context).singleProduct(id);
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Text(product.title),
      ),
    );
  }
}
