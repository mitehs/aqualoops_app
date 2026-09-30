import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String selectedCategory = 'All';

  final List<Map<String, dynamic>> products = [
    {
      'name': '20L Mineral Water',
      'price': 30,
      'category': '20L',
      'icon': Icons.water_drop,
    },
    {
      'name': '1L Water Bottle',
      'price': 20,
      'category': '1L',
      'icon': Icons.local_drink,
    },
    {
      'name': '500ml Water Bottle',
      'price': 10,
      'category': '500ml',
      'icon': Icons.water,
    },
    {
      'name': '20L Premium Water',
      'price': 40,
      'category': '20L',
      'icon': Icons.water_drop,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredProducts = selectedCategory == 'All'
        ? products
        : products
              .where((product) => product['category'] == selectedCategory)
              .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Search
            TextField(
              decoration: InputDecoration(
                hintText: 'Search water products',
                prefixIcon: const Icon(Icons.search),

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Categories
            const Text(
              'Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                children: [
                  categoryButton('All'),
                  categoryButton('20L'),
                  categoryButton('1L'),
                  categoryButton('500ml'),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Products title
            const Text(
              'All Products',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            // Product Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              itemCount: filteredProducts.length,

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 15,
                childAspectRatio: 0.70,
              ),

              itemBuilder: (context, index) {
                final product = filteredProducts[index];

                return productCard(product);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Category Button
  Widget categoryButton(String category) {
    bool isSelected = selectedCategory == category;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },

      child: Container(
        margin: const EdgeInsets.only(right: 10),

        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,

          borderRadius: BorderRadius.circular(20),

          border: Border.all(color: AppColors.primary),
        ),

        child: Text(
          category,

          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.primary,

            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Product Card
  Widget productCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Product Image
            Expanded(
              child: Container(
                width: double.infinity,

                decoration: BoxDecoration(
                  color: const Color(0xFFEFFFFF),
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Icon(
                  product['icon'],
                  size: 75,
                  color: AppColors.primary,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Product Name
            Text(
              product['name'],

              maxLines: 2,

              overflow: TextOverflow.ellipsis,

              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            // Price
            Text(
              '₹${product['price']}',

              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
            ),

            const SizedBox(height: 8),

            // Add Button
            SizedBox(
              width: double.infinity,

              height: 38,

              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${product['name']} added to cart')),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                child: const Text(
                  'Add to Cart',

                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
