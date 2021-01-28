import 'package:flutter/material.dart';
import 'package:flutterd/screens/home_Screens.dart';
import 'package:flutterd/screens/order_screens.dart';
import 'package:flutterd/state/cart_state.dart';
import 'package:provider/provider.dart';

class CartScreens extends StatelessWidget {
  static const routeName = '/cart-screens';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartState>(context).cartModel;
    if (cart == null)
      return Scaffold(
        appBar: AppBar(
          title: Text("No Cart"),
        ),
        body: Center(
          child: Text("No Card Found"),
        ),
      );
    else
      return Scaffold(
        appBar: AppBar(
          title: Text("Cart Screens"),
          actions: [
            FlatButton.icon(
              onPressed: null,
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              label: Text(
                "${cart.cartproducts.length}",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Total: ${cart.total}"),
                  Text("Date: ${cart.date}"),
                  RaisedButton(
                    color: Colors.green,
                    onPressed: cart.cartproducts.length <= 0
                        ? null
                        : () {
                            Navigator.of(context).pushNamed(OrderNew.routeName);
                          },
                    child: Text("Order"),
                  ),
                  RaisedButton(
                    color: Colors.red,
                    onPressed: cart.cartproducts.length <= 0
                        ? null
                        : () async {
                            bool isdelete = await Provider.of<CartState>(
                                    context,
                                    listen: false)
                                .deletecart(cart.id);
                            if (isdelete) {
                              Navigator.of(context)
                                  .pushReplacementNamed(HomeScreens.routeName);
                            }
                          },
                    child: Text("Delate"),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cart.cartproducts.length,
                  itemBuilder: (ctx, i) {
                    var item = cart.cartproducts[i];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.product[0].title),
                                Text("Price : ${item.price}"),
                                Text("quantity : ${item.quantity}"),
                              ],
                            ),
                            RaisedButton(
                              color: Colors.greenAccent,
                              onPressed: () {
                                Provider.of<CartState>(context, listen: false)
                                    .deletecartproduct(item.id);
                              },
                              child: Text("Delate"),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
  }
}
