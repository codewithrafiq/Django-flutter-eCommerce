import 'package:flutter/material.dart';
import 'package:flutterd/screens/cart_screens.dart';
import 'package:flutterd/screens/order_history_screens.dart';
import 'package:flutterd/state/cart_state.dart';
import 'package:provider/provider.dart';

class OrderNew extends StatefulWidget {
  static const routeName = '/order-now-screens';
  @override
  _OrderNewState createState() => _OrderNewState();
}

class _OrderNewState extends State<OrderNew> {
  final _form = GlobalKey<FormState>();
  String _email = '';
  String _phone = '';
  String _address = '';
  void _orderNew() async {
    var isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    final cart = Provider.of<CartState>(context, listen: false).cartModel;
    bool order = await Provider.of<CartState>(context, listen: false)
        .ordercart(cart.id, _address, _email, _phone);
    if (order) {
      Navigator.of(context).pushNamed(OrderScreens.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Now"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: "Email"),
                  validator: (v) {
                    if (v.isEmpty) {
                      return "Enter Your Email";
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _email = v;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Phone"),
                  validator: (v) {
                    if (v.isEmpty) {
                      return "Enter Your Phone Number";
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _phone = v;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Address"),
                  validator: (v) {
                    if (v.isEmpty) {
                      return "Enter Your Address";
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _address = v;
                  },
                ),
                Row(
                  children: [
                    RaisedButton(
                      onPressed: () {
                        _orderNew();
                      },
                      child: Text("Order"),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(CartScreens.routeName);
                      },
                      child: Text("Edit Cart"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
