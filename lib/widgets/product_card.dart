import 'package:flutter/material.dart';
import 'package:aqualoops_app/models/product.dart';
import 'package:aqualoops_app/utils/app_colors.dart';
import 'package:aqualoops_app/screens/customer/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              name: product.name,
              price: product.price,
              category: product.category,
              icon: Icons.water_drop,
            ),
          ),
        );
      },
      child: Container(
        width: 175,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.12),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Container(
              height: 125,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.water_drop,
                size: 75,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 10),
            // Product name
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            // Rating
            Row(
              children: [
                const Icon(Icons.star, size: 16, color: Colors.amber),
                const SizedBox(width: 3),
                Text(
                  product.rating.toString(),
                  style: const TextStyle(fontSize: 12, color: AppColors.grey),
                ),
              ],
            ),
            const SizedBox(height: 7),
            // Price + Add
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${product.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 22),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
