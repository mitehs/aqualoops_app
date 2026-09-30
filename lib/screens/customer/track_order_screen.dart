import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class TrackOrderScreen extends StatelessWidget {
  final String orderId;

  const TrackOrderScreen({
    super.key,
    this.orderId = '1025',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Track Order',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Order Number
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [

                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.receipt_long,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Order Number',
                        style: TextStyle(
                          color: AppColors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '#$orderId',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Order Status',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            statusItem(
              title: 'Order Placed',
              subtitle: 'Your order has been placed',
              icon: Icons.check,
              completed: true,
              isFirst: true,
            ),

            statusItem(
              title: 'Order Accepted',
              subtitle: 'Supplier accepted your order',
              icon: Icons.check,
              completed: true,
            ),

            statusItem(
              title: 'Preparing',
              subtitle: 'Your order is being prepared',
              icon: Icons.check,
              completed: true,
            ),

            statusItem(
              title: 'Out for Delivery',
              subtitle: 'Your order is on the way',
              icon: Icons.local_shipping,
              completed: true,
            ),

            statusItem(
              title: 'Delivered',
              subtitle: 'Waiting for delivery',
              icon: Icons.home,
              completed: false,
              isLast: true,
            ),

            const SizedBox(height: 20),

            // Delivery Address
            const Text(
              'Delivery Address',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Icon(
                    Icons.location_on,
                    color: AppColors.primary,
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      'Your selected delivery address',
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statusItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool completed,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Column(
          children: [

            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: completed
                    ? AppColors.primary
                    : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: completed
                    ? Colors.white
                    : Colors.grey,
                size: 22,
              ),
            ),

            if (!isLast)
              Container(
                width: 2,
                height: 55,
                color: completed
                    ? AppColors.primary
                    : Colors.grey.shade300,
              ),
          ],
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 4,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: completed
                        ? Colors.black
                        : AppColors.grey,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}