import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart.dart';

// Re-exported so existing screens can keep importing CartItem from here.
export '../models/cart.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  // Add product
  void addToCart(Product product, {int quantity = 1}) {
    final index = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      _items[index].quantity += quantity;
    } else {
      _items.add(
        CartItem(
          product: product,
          quantity: quantity,
        ),
      );
    }

    notifyListeners();
  }

  // Increase quantity
  void increaseQuantity(int index) {
    _items[index].quantity++;
    notifyListeners();
  }

  // Decrease quantity
  void decreaseQuantity(int index) {
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    }

    notifyListeners();
  }

  // Remove product
  void removeFromCart(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  // Total
  double get total {
    double amount = 0;

    for (var item in _items) {
      amount += item.total;
    }

    return amount;
  }

  // Number of products
  int get itemCount {
    int count = 0;

    for (var item in _items) {
      count += item.quantity;
    }

    return count;
  }

  // Clear cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}