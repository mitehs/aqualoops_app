import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'title': 'Order Accepted',
        'message': 'Your order #1025 has been accepted.',
        'icon': Icons.check_circle,
      },
      {
        'title': 'Out for Delivery',
        'message': 'Your order #1024 is on the way.',
        'icon': Icons.local_shipping,
      },
      {
        'title': 'Special Offer',
        'message': 'Get 10% off with coupon AQUA10.',
        'icon': Icons.local_offer,
      },
      {
        'title': 'Welcome to AquaLoop',
        'message': 'Thank you for choosing AquaLoop.',
        'icon': Icons.water_drop,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: notifications.isEmpty
          ? const Center(child: Text('No notifications'))
          : ListView.builder(
              padding: const EdgeInsets.all(18),

              itemCount: notifications.length,

              itemBuilder: (context, index) {
                final notification = notifications[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),

                  padding: const EdgeInsets.all(15),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(16),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.08),
                        blurRadius: 8,
                      ),
                    ],
                  ),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Container(
                        width: 48,
                        height: 48,

                        decoration: BoxDecoration(
                          color: AppColors.lightBlue,
                          shape: BoxShape.circle,
                        ),

                        child: Icon(
                          notification['icon'] as IconData,

                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              notification['title'] as String,

                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              notification['message'] as String,

                              style: const TextStyle(
                                color: AppColors.grey,
                                height: 1.4,
                              ),
                            ),

                            const SizedBox(height: 5),

                            const Text(
                              'Just now',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
