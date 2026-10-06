import 'package:flutter/material.dart';
import 'package:aqualoops_app/models/product.dart';
import 'package:aqualoops_app/utils/app_colors.dart';
import 'package:aqualoops_app/screens/admin/add_product_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController searchController = TextEditingController();

  String searchText = '';
  String selectedCategory = 'All';

  final List<String> categories = const ['All', '20L', '1L', '500ml'];

  final List<Product> products = [
    Product(
      id: 1,
      name: '20L Mineral Water',
      description: 'Pure mineral water for your daily needs.',
      price: 30,
      image: '',
      stock: 120,
      category: '20L',
      rating: 4.8,
    ),
    Product(
      id: 2,
      name: '20L Premium Water',
      description: 'Premium quality drinking water.',
      price: 40,
      image: '',
      stock: 64,
      category: '20L',
      rating: 4.9,
    ),
    Product(
      id: 3,
      name: '20L Alkaline Water',
      description: 'Balanced pH alkaline drinking water.',
      price: 45,
      image: '',
      stock: 8,
      category: '20L',
      rating: 4.7,
    ),
    Product(
      id: 4,
      name: '1L Water Bottle',
      description: 'Fresh drinking water in a convenient bottle.',
      price: 20,
      image: '',
      stock: 150,
      category: '1L',
      rating: 4.7,
    ),
    Product(
      id: 5,
      name: '1L Sparkling Water',
      description: 'Light and refreshing sparkling water.',
      price: 25,
      image: '',
      stock: 0,
      category: '1L',
      rating: 4.5,
    ),
    Product(
      id: 6,
      name: '500ml Water Bottle',
      description: 'Fresh and pure drinking water.',
      price: 10,
      image: '',
      stock: 18,
      category: '500ml',
      rating: 4.6,
    ),
    Product(
      id: 7,
      name: '500ml Kids Bottle',
      description: 'Handy bottle sized for kids.',
      price: 12,
      image: '',
      stock: 90,
      category: '500ml',
      rating: 4.6,
    ),
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void confirmDelete(Product product) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Delete Product?'),
          content: Text('Are you sure you want to delete ${product.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                setState(() {
                  products.remove(product);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.name} deleted (demo)')),
                );
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: AppColors.danger),
              ),
            ),
          ],
        );
      },
    );
  }

  void editProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddProductScreen()),
    );
  }

  Widget statusChip(int stock) {
    if (stock == 0) {
      return chip('Out of Stock', AppColors.danger);
    }
    if (stock <= 20) {
      return chip('Low Stock', Colors.orange);
    }
    return chip('In Stock', AppColors.success);
  }

  Widget chip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // The products that match the selected category and the search text.
    String query = searchText.trim().toLowerCase();
    List<Product> results = [];
    for (int i = 0; i < products.length; i++) {
      Product product = products[i];
      bool matchesCategory =
          selectedCategory == 'All' || product.category == selectedCategory;
      bool matchesSearch =
          query.isEmpty ||
          product.name.toLowerCase().contains(query) ||
          product.category.toLowerCase().contains(query);
      if (matchesCategory && matchesSearch) {
        results.add(product);
      }
    }

    // The small "x" button that clears the search field.
    Widget? clearButton;
    if (searchText.isEmpty) {
      clearButton = null;
    } else {
      clearButton = IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          searchController.clear();
          setState(() {
            searchText = '';
          });
        },
      );
    }

    // One chip for every category.
    List<Widget> categoryChips = [];
    for (int i = 0; i < categories.length; i++) {
      String category = categories[i];
      categoryChips.add(
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            label: Text(category),
            selected: selectedCategory == category,
            onSelected: (value) {
              setState(() {
                selectedCategory = category;
              });
            },
            showCheckmark: false,
            backgroundColor: Colors.white,
            selectedColor: AppColors.adminPrimary,
            side: const BorderSide(color: AppColors.adminPrimary),
            labelStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: selectedCategory == category
                  ? Colors.white
                  : AppColors.adminPrimary,
            ),
          ),
        ),
      );
    }

    // The list of products, or a message when nothing matches.
    Widget productsList;
    if (results.isEmpty) {
      productsList = const Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Text(
            'No products found',
            style: TextStyle(color: AppColors.grey),
          ),
        ),
      );
    } else {
      productsList = ListView.builder(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 90),
        itemCount: results.length,
        itemBuilder: (context, index) {
          final product = results[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: cardDecoration(),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.adminPrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.water_drop_outlined,
                    color: AppColors.adminPrimary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            product.category,
                            style: const TextStyle(
                              color: AppColors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 8),
                          statusChip(product.stock),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '₹${product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.adminPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        editProduct(product);
                      },
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: AppColors.adminPrimary,
                      ),
                      tooltip: 'Edit',
                    ),
                    IconButton(
                      onPressed: () {
                        confirmDelete(product);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: AppColors.danger,
                      ),
                      tooltip: 'Delete',
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: AppColors.adminBackground,
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.adminPrimary,
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'admin-products-add',
        backgroundColor: AppColors.adminPrimary,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.adminPrimary,
                ),
                suffixIcon: clearButton,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
              children: categoryChips,
            ),
          ),
          Expanded(child: productsList),
        ],
      ),
    );
  }

  BoxDecoration cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}
