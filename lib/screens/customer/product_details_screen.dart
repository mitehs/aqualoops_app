import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import 'checkout_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String name;
  final double price;
  final String category;
  final IconData icon;

  const ProductDetailsScreen({
    super.key,
    required this.name,
    required this.price,
    required this.category,
    required this.icon,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  double get totalPrice {
    return widget.price * quantity;
  }

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Product Image
            Container(
              width: double.infinity,
              height: 280,

              decoration: BoxDecoration(
                color: const Color(0xFFEFFFFF),
                borderRadius: BorderRadius.circular(25),
              ),

              child: Icon(widget.icon, size: 150, color: AppColors.primary),
            ),

            const SizedBox(height: 25),

            // Product Name
            Text(
              widget.name,

              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // Category
            Text(
              widget.category,

              style: const TextStyle(color: AppColors.grey, fontSize: 15),
            ),

            const SizedBox(height: 15),

            // Price
            Text(
              '₹${widget.price.toStringAsFixed(0)}',

              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
            ),

            const SizedBox(height: 12),

            // Rating
            Row(
              children: const [
                Icon(Icons.star, color: Colors.amber, size: 22),

                Icon(Icons.star, color: Colors.amber, size: 22),

                Icon(Icons.star, color: Colors.amber, size: 22),

                Icon(Icons.star, color: Colors.amber, size: 22),

                Icon(Icons.star_half, color: Colors.amber, size: 22),

                SizedBox(width: 8),

                Text(
                  '4.8 (120 Reviews)',
                  style: TextStyle(color: AppColors.grey),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Description
            const Text(
              'Description',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              'Pure and fresh drinking water for '
              'your daily needs. AquaLoop provides '
              'quality water delivered directly to '
              'your doorstep.',
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 15,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            // Quantity
            const Text(
              'Quantity',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                // Minus
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.primary),
                  ),

                  child: IconButton(
                    onPressed: decreaseQuantity,
                    icon: const Icon(Icons.remove),
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(width: 20),

                // Quantity
                Text(
                  '$quantity',

                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(width: 20),

                // Plus
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: IconButton(
                    onPressed: increaseQuantity,
                    icon: const Icon(Icons.add),
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Total
            Container(
              padding: const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: const Color(0xFFEFFFFF),
                borderRadius: BorderRadius.circular(15),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  Text(
                    '₹${totalPrice.toStringAsFixed(0)}',

                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Add To Cart
            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton(
                onPressed: () {
                  final product = Product(
                    id: 1,
                    name: widget.name,
                    description: 'Pure and fresh drinking water',
                    price: widget.price,
                    image: '',
                    stock: 100,
                  );

                  Provider.of<CartProvider>(
                    context,
                    listen: false,
                  ).addToCart(product, quantity: quantity);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$quantity × ${widget.name} added to cart'),
                      backgroundColor: AppColors.secondary,
                    ),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                child: const Text(
                  'ADD TO CART',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Buy Now
            SizedBox(
              width: double.infinity,
              height: 52,

              child: OutlinedButton(
                onPressed: () {
                  // Add to cart and go straight to checkout.
                  final product = Product(
                    id: 1,
                    name: widget.name,
                    description: 'Pure and fresh drinking water',
                    price: widget.price,
                    image: '',
                    stock: 100,
                  );

                  Provider.of<CartProvider>(
                    context,
                    listen: false,
                  ).addToCart(product, quantity: quantity);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CheckoutScreen(),
                    ),
                  );
                },

                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                child: const Text(
                  'BUY NOW',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
