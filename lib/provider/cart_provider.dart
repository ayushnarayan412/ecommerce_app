import 'package:ecommerce_app/models/products.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Products> _cart = [];
  double _totalAmount = 0;

  List<Products> get cart => _cart;

  double get totalAmount {
    _totalAmount = 0;
    for (int i = 0; i < _cart.length; i++) {
      _totalAmount += _cart[i].price;
    }
    notifyListeners();
    return _totalAmount;
  }

  void addProduct(Products product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeProduct(Products product) {
    _cart.remove(product);
    notifyListeners();
  }
}
