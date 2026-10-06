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
}
