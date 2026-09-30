class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String role; // customer | admin | supplier
  final String address;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone = '',
    this.role = 'customer',
    this.address = '',
  });

  bool get isAdmin => role == 'admin';
  bool get isSupplier => role == 'supplier';

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? role,
    String? address,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      address: address ?? this.address,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? 'customer',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'address': address,
    };
  }
}
