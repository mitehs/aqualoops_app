import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';

class OrderDetails extends StatelessWidget {
  final String orderId;
  final String customer;
  final double amount;
  final String status;

  const OrderDetails({
    super.key,
    this.orderId = '#AQ1001',
    this.customer = 'Priya Sharma',
    this.amount = 300,
    this.status = 'Pending',
  });

  final List<_OrderItem> _items = const [
    _OrderItem(name: '20L Mineral Water', qty: 2, price: 120),
    _OrderItem(name: '1L Water Bottle', qty: 3, price: 20),
  ];

  @override
  Widget build(BuildContext context) {
    final int currentStep = _currentStepIndex();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =====================================
            // ORDER HEADER
            // =====================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        orderId,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _statusChip(status),
                    ],
                  ),

                  const SizedBox(height: 10),

                  const Row(
                    children: [
                      Icon(Icons.schedule, size: 15, color: AppColors.grey),
                      SizedBox(width: 6),
                      Text(
                        '28 Sep 2026, 10:30 AM',
                        style: TextStyle(color: AppColors.grey, fontSize: 13),
                      ),
                    ],
                  ),

                  const Divider(height: 26),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Order Amount',
                        style: TextStyle(color: AppColors.grey),
                      ),
                      Text(
                        '₹${amount.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.supplierDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // =====================================
            // CUSTOMER
            // =====================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundColor: AppColors.supplierLight,
                    child: Icon(
                      Icons.person,
                      color: AppColors.supplierPrimary,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Row(
                          children: [
                            Icon(Icons.phone, size: 15, color: AppColors.grey),
                            SizedBox(width: 6),
                            Text(
                              '+91 98765 43210',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: AppColors.supplierPrimary,
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                '14th Main, Indiranagar, Bengaluru 560038',
                                style: TextStyle(fontSize: 13, height: 1.4),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.call, color: AppColors.success),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =====================================
            // ITEMS
            // =====================================
            const Text(
              'Order Items',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.supplierLight,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.water_drop_outlined,
                              color: AppColors.supplierPrimary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'x ${item.qty}',
                                  style: const TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 12.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '₹${(item.price * item.qty).toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.supplierDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Divider(height: 22),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '₹${amount.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.supplierDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // =====================================
            // DELIVERY INSTRUCTIONS
            // =====================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.supplierLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: AppColors.supplierDark),
                      SizedBox(width: 8),
                      Text(
                        'Delivery Instructions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please call before arriving. If no one answers, leave the cans beside the main door and send a message.',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // =====================================
            // MAP PLACEHOLDER
            // =====================================
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: AppColors.supplierLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.supplierPrimary.withValues(alpha: 0.25),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map_outlined, size: 46, color: AppColors.supplierPrimary),
                  SizedBox(height: 8),
                  Text(
                    'Map view',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =====================================
            // STATUS TIMELINE
            // =====================================
            const Text(
              'Order Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _StatusStep(
                    title: 'Placed',
                    subtitle: 'Order received from the customer',
                    isCompleted: currentStep > 0,
                    isActive: currentStep == 0,
                  ),
                  _StatusStep(
                    title: 'Accepted',
                    subtitle: 'Supplier accepted the order',
                    isCompleted: currentStep > 1,
                    isActive: currentStep == 1,
                  ),
                  _StatusStep(
                    title: 'Out for Delivery',
                    subtitle: 'Order is on the way to the customer',
                    isCompleted: currentStep > 2,
                    isActive: currentStep == 2,
                  ),
                  _StatusStep(
                    title: 'Delivered',
                    subtitle: 'Order handed over to the customer',
                    isCompleted: currentStep > 3,
                    isActive: currentStep == 3,
                    isLast: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // =====================================
            // ACTIONS
            // =====================================
            status == 'Pending'
                ? CustomButton(
                    label: 'ACCEPT ORDER',
                    onPressed: () {
                      _finish(context, 'Order $orderId accepted');
                    },
                  )
                : CustomButton(
                    label: 'MARK AS DELIVERED',
                    onPressed: () {
                      _finish(context, 'Order $orderId marked as delivered');
                    },
                  ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  int _currentStepIndex() {
    if (status == 'Accepted') {
      return 1;
    }

    if (status == 'Out for Delivery') {
      return 2;
    }

    if (status == 'Delivered') {
      return 4;
    }

    return 0;
  }

  void _finish(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));

    Navigator.pop(context);
  }

  Widget _statusChip(String status) {
    Color color;

    if (status == 'Delivered') {
      color = AppColors.success;
    } else if (status == 'Out for Delivery') {
      color = AppColors.supplierPrimary;
    } else {
      color = const Color(0xFFF59E0B);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 11.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _StatusStep extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isActive;
  final bool isLast;

  const _StatusStep({
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.isActive,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? AppColors.supplierPrimary
                    : isActive
                    ? Colors.white
                    : Colors.grey.shade200,
                border: isActive
                    ? Border.all(color: AppColors.supplierPrimary, width: 2)
                    : null,
              ),
              child: Icon(
                isCompleted
                    ? Icons.check
                    : isActive
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                size: 20,
                color: isCompleted ? Colors.white : AppColors.supplierPrimary,
              ),
            ),

            if (!isLast)
              Container(
                width: 2,
                height: 46,
                color: isCompleted ? AppColors.supplierPrimary : Colors.grey.shade300,
              ),
          ],
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 7, bottom: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isCompleted || isActive
                        ? Colors.black
                        : AppColors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: AppColors.grey, fontSize: 12.5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OrderItem {
  final String name;
  final int qty;
  final double price;

  const _OrderItem({
    required this.name,
    required this.qty,
    required this.price,
  });
}
