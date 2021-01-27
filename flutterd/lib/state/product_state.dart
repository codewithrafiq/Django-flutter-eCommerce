import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../models/product.dart';
import 'package:http/http.dart' as http;

class ProductState with ChangeNotifier {
  List<Product> _products = [];

  Future<bool> getProducts() async {
    String url = 'http://10.0.2.2:8000/api/products/';
    try {
      http.Response response = await http.get(url, headers: {
        'Authorization': "token 831740abf0cf45d29177afcce9b836af9457631a"
      });
      var data = json.decode(response.body) as List;
      // print(data);
      List<Product> temp = [];
      data.forEach((element) {
        Product product = Product.fromJson(element);
        temp.add(product);
      });
      _products = temp;
      return true;
    } catch (e) {
      print("e getProducts");
      print(e);
      return false;
    }
  }

  List<Product> get poducts {
    return [..._products];
  }

  Product singleProduct(int id) {
    return _products.firstWhere((element) => element.id == id);
  }
}
