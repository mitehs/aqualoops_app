import 'product.dart';

class Order {
  final String id;
  final DateTime date;
  final List<CartOrderItem> items;
  final double total;
  final String address;
  final String paymentMethod;
  final String status; // Placed | Accepted | Packed | Out for Delivery | Delivered

  Order({
    required this.id,
    required this.date,
    required this.items,
    required this.total,
    required this.address,
    required this.paymentMethod,
    this.status = 'Placed',
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      items: (json['items'] as List<dynamic>? ?? [])
          .map((item) => CartOrderItem.fromJson(item))
          .toList(),
      total: double.tryParse(json['total'].toString()) ?? 0,
      address: json['address'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
      status: json['status'] ?? 'Placed',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
      'address': address,
      'paymentMethod': paymentMethod,
      'status': status,
    };
  }
}

class CartOrderItem {
  final Product product;
  final int quantity;

  CartOrderItem({required this.product, required this.quantity});

  double get total => product.price * quantity;

  factory CartOrderItem.fromJson(Map<String, dynamic> json) {
    return CartOrderItem(
      product: Product.fromJson(json['product'] ?? {}),
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }
}
