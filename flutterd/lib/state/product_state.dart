import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import '../models/product.dart';
import 'package:http/http.dart' as http;

class ProductState with ChangeNotifier {
  LocalStorage storage = new LocalStorage('usertoken');

  List<Product> _products = [];

  Future<bool> getProducts() async {
    String url = 'http://10.0.2.2:8000/api/products/';
    var token = storage.getItem('token');
    try {
      http.Response response =
          await http.get(url, headers: {'Authorization': "token $token"});
      var data = json.decode(response.body) as List;
      // print(data);
      List<Product> temp = [];
      data.forEach((element) {
        Product product = Product.fromJson(element);
        temp.add(product);
      });
      _products = temp;
      notifyListeners();
      return true;
    } catch (e) {
      print("e getProducts");
      print(e);
      return false;
    }
  }

  Future<void> favoritButton(int id) async {
    String url = 'http://10.0.2.2:8000/api/favorit/';
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
      // var data = json.decode(response.body);
      // print(data);
      getProducts();
    } catch (e) {
      print("e favoritButton");
      print(e);
    }
  }

  List<Product> get poducts {
    return [..._products];
  }

  List<Product> get favorits {
    return _products.where((element) => element.favorit == true).toList();
  }

  Product singleProduct(int id) {
    return _products.firstWhere((element) => element.id == id);
  }
}
