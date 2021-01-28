import 'package:flutter/material.dart';
import 'package:flutterd/screens/cart_screens.dart';
import 'package:flutterd/state/cart_state.dart';
import 'package:flutterd/state/product_state.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreens extends StatelessWidget {
  static const routeName = '/product-details-screens';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final product = Provider.of<ProductState>(context).singleProduct(id);
    final cart = Provider.of<CartState>(context).cartModel;
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        actions: [
          FlatButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreens.routeName);
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            label: Text(
              cart != null ? "${cart.cartproducts.length}" : '',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Image.network(
              "http://10.0.2.2:8000${product.image}",
              fit: BoxFit.cover,
              height: 250,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title),
                    Text("Marcket Price : \$ ${product.marcketPrice}"),
                    Text("selling Price : \$ ${product.sellingPrice}"),
                  ],
                ),
                RaisedButton.icon(
                  color: Colors.green,
                  onPressed: () {
                    Provider.of<CartState>(context, listen: false)
                        .addtoCart(id);
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Add To Card",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Text(product.description)
          ],
        ),
      ),
    );
  }
}
