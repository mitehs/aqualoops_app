class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;
  final int stock;
  final String category;
  final double rating;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.stock,
    this.category = '',
    this.rating = 0,
  });
}
