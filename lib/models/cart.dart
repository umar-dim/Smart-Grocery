import 'package:flutter/material.dart';

class CartItem {
  final String name;

  CartItem(this.name);
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }
}
