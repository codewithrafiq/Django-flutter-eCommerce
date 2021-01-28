class OrderModel {
  int id;
  String email;
  String phone;
  String address;
  Cart cart;

  OrderModel({this.id, this.email, this.phone, this.address, this.cart});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    if (this.cart != null) {
      data['cart'] = this.cart.toJson();
    }
    return data;
  }
}

class Cart {
  int id;
  int total;
  bool isComplit;
  String date;
  int user;

  Cart({this.id, this.total, this.isComplit, this.date, this.user});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    isComplit = json['isComplit'];
    date = json['date'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['isComplit'] = this.isComplit;
    data['date'] = this.date;
    data['user'] = this.user;
    return data;
  }
}
