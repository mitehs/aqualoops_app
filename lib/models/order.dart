import 'package:aqualoops_app/models/product.dart';

class Order {
  final String id;
  final DateTime date;
  final List<CartOrderItem> items;
  final double total;
  final String address;
  final String paymentMethod;
  final String
  status; // Placed | Accepted | Packed | Out for Delivery | Delivered

  Order({
    required this.id,
    required this.date,
    required this.items,
    required this.total,
    required this.address,
    required this.paymentMethod,
    this.status = 'Placed',
  });
}

class CartOrderItem {
  final Product product;
  final int quantity;

  CartOrderItem({required this.product, required this.quantity});
}
