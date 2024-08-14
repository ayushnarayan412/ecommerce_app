import 'package:ecommerce_app/models/products.dart';
import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  final Set<Products> _favorite = {};
  Set<Products> get favorite => _favorite;

  void addToFavorite(Products product) {
    if (_favorite.contains(product)) {
      return;
      
    } else {
      _favorite.add(product);
      notifyListeners();
    }
  }

  void removeFavorite(Products product) {
    _favorite.remove(product);
    notifyListeners();
  }
}
