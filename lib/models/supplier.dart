class Supplier {
  final String name;
  final String route;
  final String phone;
  final String email;
  final String vehicle;
  final double earnings;
  bool available;

  Supplier({
    required this.name,
    required this.route,
    required this.phone,
    this.email = '',
    this.vehicle = '',
    this.earnings = 0,
    this.available = true,
  });
}
