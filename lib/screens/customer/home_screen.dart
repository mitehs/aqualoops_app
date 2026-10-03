import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../providers/product_provider.dart';
import '../../utils/app_colors.dart';
import '../../widgets/product_card.dart';
import '../../widgets/category_card.dart';

import 'product_screen.dart';
import 'cart_screen.dart';
import 'my_orders_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomeContent(),
    ProductScreen(),
    CartScreen(),
    MyOrdersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,

        type: BottomNavigationBarType.fixed,

        selectedItemColor: AppColors.primary,

        unselectedItemColor: Colors.grey,

        showUnselectedLabels: true,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop_outlined),
            activeIcon: Icon(Icons.water_drop),
            label: 'Products',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// =====================================================
// HOME CONTENT
// =====================================================

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final TextEditingController searchController = TextEditingController();

  String searchText = '';

  final List<Product> products = [
    Product(
      id: 1,
      name: '20L Mineral Water',
      description: 'Pure mineral water for your daily needs.',
      price: 30,
      image: '',
      stock: 100,
      category: '20L',
      rating: 4.8,
    ),

    Product(
      id: 2,
      name: '1L Water Bottle',
      description: 'Fresh drinking water in a convenient bottle.',
      price: 20,
      image: '',
      stock: 150,
      category: '1L',
      rating: 4.7,
    ),

    Product(
      id: 3,
      name: '500ml Water Bottle',
      description: 'Fresh and pure drinking water.',
      price: 10,
      image: '',
      stock: 200,
      category: '500ml',
      rating: 4.6,
    ),

    Product(
      id: 4,
      name: '20L Premium Water',
      description: 'Premium quality drinking water.',
      price: 40,
      image: '',
      stock: 80,
      category: '20L',
      rating: 4.9,
    ),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ProductProvider>().loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Products come from ProductProvider (with local demo data as a
    // fallback while the provider is still loading).
    final providerProducts = context.watch<ProductProvider>().products;

    final sourceProducts = providerProducts.isEmpty
        ? products
        : providerProducts;

    List<Product> filteredProducts = sourceProducts.where((product) {
      return product.name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 25),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // =====================================
            // HEADER
            // =====================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      children: [
                        const Text(
                          'Aqua',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                          ),
                        ),

                        const Text(
                          'Loop',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 3),

                    const Text(
                      'Pure Water Delivery',
                      style: TextStyle(fontSize: 11, color: AppColors.grey),
                    ),
                  ],
                ),

                Row(
                  children: [
                    // Notification
                    IconButton(
                      onPressed: () {},

                      icon: const Icon(Icons.notifications_none),
                    ),

                    // Cart
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CartScreen()),
                        );
                      },

                      icon: const Icon(Icons.shopping_cart_outlined),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 25),

            // =====================================
            // GREETING
            // =====================================
            const Text(
              'Hello, User 👋',

              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            const Text(
              'What would you like today?',

              style: TextStyle(fontSize: 14, color: AppColors.grey),
            ),

            const SizedBox(height: 18),

            // const Text('____________________________________________________________'),
            // =====================================
            // SEARCH
            // =====================================
            TextField(
              controller: searchController,

              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },

              decoration: InputDecoration(
                hintText: 'Search for water...',

                prefixIcon: const Icon(Icons.search, color: AppColors.primary),

                suffixIcon: searchText.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          searchController.clear();

                          setState(() {
                            searchText = '';
                          });
                        },

                        icon: const Icon(Icons.clear),
                      )
                    : null,

                filled: true,

                fillColor: Colors.white,

                contentPadding: const EdgeInsets.symmetric(vertical: 15),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),

                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // =====================================
            // CATEGORIES
            // =====================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                const Text(
                  'Categories',

                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProductScreen()),
                    );
                  },

                  child: const Text('See All'),
                ),
              ],
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 105,

              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: Row(
                  children: [
                    CategoryCard(
                      title: '20L Water',
                      icon: Icons.water_drop,
                      onTap: () {},
                    ),

                    CategoryCard(
                      title: '1L Water',
                      icon: Icons.local_drink,
                      onTap: () {},
                    ),

                    CategoryCard(
                      title: '500ml',
                      icon: Icons.water,
                      onTap: () {},
                    ),

                    CategoryCard(
                      title: 'Premium',
                      icon: Icons.auto_awesome,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // =====================================
            // PROMOTIONAL BANNER
            // =====================================
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ),

                borderRadius: BorderRadius.circular(20),
              ),

              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const Text(
                          'Pure Water,\nDelivered Fast!',

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'Get fresh water at\nyour doorstep.',

                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),

                        const SizedBox(height: 12),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProductScreen(),
                              ),
                            );
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,

                            foregroundColor: AppColors.secondary,
                          ),

                          child: const Text('Shop Now'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  const Icon(Icons.water_drop, color: Colors.white, size: 90),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =====================================
            // POPULAR PRODUCTS
            // =====================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                const Text(
                  'Popular Products',

                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProductScreen()),
                    );
                  },

                  child: const Text('See All'),
                ),
              ],
            ),

            const SizedBox(height: 10),

            if (filteredProducts.isEmpty)
              const Padding(
                padding: EdgeInsets.all(30),

                child: Center(
                  child: Text(
                    'No products found',
                    style: TextStyle(color: AppColors.grey),
                  ),
                ),
              )
            else
              SizedBox(
                height: 265,

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,

                  itemCount: filteredProducts.length,

                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 14),

                      child: ProductCard(product: filteredProducts[index]),
                    );
                  },
                ),
              ),

            const SizedBox(height: 25),

            // =====================================
            // WHY AQUA LOOP
            // =====================================
            const Text(
              'Why AquaLoop?',

              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                benefitCard(Icons.verified, 'Pure Water'),

                benefitCard(Icons.local_shipping, 'Fast Delivery'),

                benefitCard(Icons.support_agent, '24/7 Support'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget benefitCard(IconData icon, String title) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),

        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(15),
        ),

        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 28),

            const SizedBox(height: 8),

            Text(
              title,
              textAlign: TextAlign.center,

              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
