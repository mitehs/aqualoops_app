import 'package:flutter/material.dart';
import '../models/order.dart';

// Re-exported so existing screens can keep importing Order / CartOrderItem
// from this file.
export '../models/order.dart';

class OrderProvider extends ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  void placeOrder({
    required List<CartOrderItem> items,
    required double total,
    required String address,
    required String paymentMethod,
  }) {
    _orders.insert(
      0,
      Order(
        id: '#AQ${1001 + _orders.length}',
        date: DateTime.now(),
        items: items,
        total: total,
        address: address,
        paymentMethod: paymentMethod,
      ),
    );
    notifyListeners();
  }
}
