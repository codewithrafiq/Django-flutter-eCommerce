import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterd/models/cart.dart';
import 'package:flutterd/models/order.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

class CartState with ChangeNotifier {
  LocalStorage storage = new LocalStorage('usertoken');
  // var token = storage.getItem('token');
  CartModel _cartModel;
  List<OrderModel> _orderder;

  Future<void> getCartDatas() async {
    String url = 'http://10.0.2.2:8000/api/cart/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.get(url, headers: {
        "Authorization": "token $token",
      });
      var data = json.decode(response.body) as Map;
      print(data['error']);
      List<CartModel> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          CartModel cartModel = CartModel.fromJson(element);
          demo.add(cartModel);
        });
        _cartModel = demo[0];
        notifyListeners();
      } else {
        print(data['data']);
      }
    } catch (e) {
      print("error getCartDatas");
    }
  }

  Future<void> getoldOrders() async {
    String url = 'http://10.0.2.2:8000/api/order/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.get(url, headers: {
        "Authorization": "token $token",
      });
      var data = json.decode(response.body) as Map;
      // print(data);
      List<OrderModel> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          OrderModel oldOrder = OrderModel.fromJson(element);
          demo.add(oldOrder);
        });
        _orderder = demo;
        notifyListeners();
      } else {
        print(data['data']);
      }
    } catch (e) {
      print("error getoldOrders");
    }
  }

  Future<void> addtoCart(int id) async {
    String url = 'http://10.0.2.2:8000/api/addtocart/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.post(url,
          body: json.encode({
            'id': id,
          }),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          });
      var data = json.decode(response.body) as Map;
      if (data['error'] == false) {
        getCartDatas();
      }
    } catch (e) {
      print("e addtoCart");
      print(e);
    }
  }

  Future<void> deletecartproduct(int id) async {
    String url = 'http://10.0.2.2:8000/api/delatecartprod/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.post(url,
          body: json.encode({
            'id': id,
          }),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          });
      var data = json.decode(response.body) as Map;
      if (data['error'] == false) {
        getCartDatas();
      }
    } catch (e) {
      print("e addtoCart");
      print(e);
    }
  }

  Future<bool> deletecart(int id) async {
    String url = 'http://10.0.2.2:8000/api/deletecart/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.post(url,
          body: json.encode({
            'id': id,
          }),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          });
      var data = json.decode(response.body) as Map;
      if (data['error'] == false) {
        getCartDatas();
        _cartModel = null;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("e deletecart");
      print(e);

      return false;
    }
  }

  Future<bool> ordercart(
      int cartid, String address, String email, String phone) async {
    String url = 'http://10.0.2.2:8000/api/ordernow/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.post(url,
          body: json.encode({
            "cartid": cartid,
            "address": address,
            "email": email,
            "phone": phone,
          }),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          });
      var data = json.decode(response.body) as Map;
      if (data['error'] == false) {
        getCartDatas();
        getoldOrders();
        _cartModel = null;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("e deletecart");
      print(e);

      return false;
    }
  }

  CartModel get cartModel {
    if (_cartModel != null) {
      return _cartModel;
    } else {
      return null;
    }
  }

  List<OrderModel> get oldorder {
    if (_orderder != null) {
      return [..._orderder];
    } else {
      return null;
    }
  }
}
