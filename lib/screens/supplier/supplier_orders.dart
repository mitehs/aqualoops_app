import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import 'order_details.dart';

class SupplierOrders extends StatefulWidget {
  const SupplierOrders({super.key});

  @override
  State<SupplierOrders> createState() => _SupplierOrdersState();
}

class _SupplierOrdersState extends State<SupplierOrders> {
  final List<String> filters = const ['All', 'Pending', 'Delivered'];

  String selectedFilter = 'All';

  final List<_SupplierOrder> orders = const [
    _SupplierOrder(
      orderId: '#AQ1001',
      customer: 'Priya Sharma',
      items: '20L Mineral Water x 2, 1L Water Bottle x 3',
      address: '14th Main, Indiranagar, Bengaluru',
      amount: 300,
      status: 'Pending',
    ),
    _SupplierOrder(
      orderId: '#AQ1002',
      customer: 'Amit Verma',
      items: '20L Mineral Water x 1, 1L Water Bottle x 4',
      address: 'CMH Road, Domlur, Bengaluru',
      amount: 190,
      status: 'Out for Delivery',
    ),
    _SupplierOrder(
      orderId: '#AQ1003',
      customer: 'Sneha Reddy',
      items: '20L Premium Water x 3',
      address: 'HAL 2nd Stage, Bengaluru',
      amount: 360,
      status: 'Delivered',
    ),
    _SupplierOrder(
      orderId: '#AQ1004',
      customer: 'Karan Mehta',
      items: '500ml Bottle x 6, 1L Water Bottle x 2',
      address: 'Old Airport Road, Bengaluru',
      amount: 100,
      status: 'Delivered',
    ),
    _SupplierOrder(
      orderId: '#AQ1005',
      customer: 'Ananya Iyer',
      items: '20L Mineral Water x 2, 1L Water Bottle x 6',
      address: 'Koramangala 5th Block, Bengaluru',
      amount: 300,
      status: 'Pending',
    ),
    _SupplierOrder(
      orderId: '#AQ1006',
      customer: 'Rohit Nair',
      items: '20L Premium Water x 1',
      address: 'Sector 1, HSR Layout, Bengaluru',
      amount: 120,
      status: 'Delivered',
    ),
    _SupplierOrder(
      orderId: '#AQ1007',
      customer: 'Meera Joshi',
      items: '20L Mineral Water x 4',
      address: 'JP Nagar 6th Phase, Bengaluru',
      amount: 480,
      status: 'Pending',
    ),
  ];

  List<_SupplierOrder> get filteredOrders {
    if (selectedFilter == 'All') {
      return orders;
    }

    return orders.where((order) => order.status == selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final visibleOrders = filteredOrders;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Column(
        children: [
          _buildFilters(),

          Expanded(
            child: visibleOrders.isEmpty
                ? const _EmptyOrders()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
                    itemCount: visibleOrders.length,
                    itemBuilder: (context, index) =>
                        _buildOrderCard(visibleOrders[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 4),
      child: Row(
        children: filters.map((filter) {
          final bool isSelected = selectedFilter == filter;

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              label: Text(filter),
              selected: isSelected,
              showCheckmark: false,
              selectedColor: AppColors.supplierPrimary,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : AppColors.grey,
              ),
              onSelected: (_) {
                setState(() {
                  selectedFilter = filter;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOrderCard(_SupplierOrder order) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OrderDetails(
              orderId: order.orderId,
              customer: order.customer,
              amount: order.amount,
              status: order.status,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.orderId,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                _statusChip(order.status),
              ],
            ),

            const SizedBox(height: 10),

            Text(
              order.customer,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 4),

            Text(
              order.items,
              style: const TextStyle(color: AppColors.grey, fontSize: 13),
            ),

            const SizedBox(height: 10),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: AppColors.grey,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    order.address,
                    style: const TextStyle(
                      color: AppColors.grey,
                      fontSize: 12.5,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),

            const Divider(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${order.amount.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.supplierDark,
                  ),
                ),
                const Row(
                  children: [
                    Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.supplierPrimary,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: AppColors.supplierPrimary,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _EmptyOrders extends StatelessWidget {
  const _EmptyOrders();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 60, color: AppColors.grey),
          SizedBox(height: 14),
          Text(
            'No orders found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.grey,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Orders matching this filter will appear here.',
            style: TextStyle(color: AppColors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _SupplierOrder {
  final String orderId;
  final String customer;
  final String items;
  final String address;
  final double amount;
  final String status;

  const _SupplierOrder({
    required this.orderId,
    required this.customer,
    required this.items,
    required this.address,
    required this.amount,
    required this.status,
  });
}
