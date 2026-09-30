import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../widgets/bottom_navbar.dart';
import '../../widgets/custom_button.dart';
import 'delivery_screen.dart';
import 'earnings_screen.dart';
import 'supplier_login.dart';
import 'supplier_orders.dart';

class SupplierDashboard extends StatefulWidget {
  const SupplierDashboard({super.key});

  @override
  State<SupplierDashboard> createState() => _SupplierDashboardState();
}

class _SupplierDashboardState extends State<SupplierDashboard> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    _DashboardHome(),
    SupplierOrders(),
    DeliveryScreen(),
    EarningsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack keeps the state of every tab alive.
      body: IndexedStack(index: selectedIndex, children: pages),

      bottomNavigationBar: BottomNavBar(
        currentIndex: selectedIndex,
        selectedColor: AppColors.supplierPrimary,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Dashboard',
          ),
          BottomNavItem(
            icon: Icons.receipt_long_outlined,
            activeIcon: Icons.receipt_long,
            label: 'Orders',
          ),
          BottomNavItem(
            icon: Icons.navigation_outlined,
            activeIcon: Icons.navigation,
            label: 'Delivery',
          ),
          BottomNavItem(
            icon: Icons.account_balance_wallet_outlined,
            activeIcon: Icons.account_balance_wallet,
            label: 'Earnings',
          ),
        ],
      ),
    );
  }
}

// =====================================================
// DASHBOARD HOME TAB
// =====================================================

class _DashboardHome extends StatelessWidget {
  const _DashboardHome();

  final List<_RouteStop> stops = const [
    _RouteStop(
      number: 1,
      customer: 'Priya Sharma',
      address: '14th Main, Indiranagar',
      distance: '0.8 km',
      status: 'Delivered',
    ),
    _RouteStop(
      number: 2,
      customer: 'Amit Verma',
      address: 'CMH Road, Domlur',
      distance: '1.6 km',
      status: 'In Route',
      isCurrent: true,
    ),
    _RouteStop(
      number: 3,
      customer: 'Sneha Reddy',
      address: 'HAL 2nd Stage',
      distance: '2.4 km',
      status: 'Pending',
    ),
    _RouteStop(
      number: 4,
      customer: 'Karan Mehta',
      address: 'Old Airport Road',
      distance: '3.1 km',
      status: 'Pending',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),

              const SizedBox(height: 20),

              // Today's stats
              const Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: "Today's Deliveries",
                      value: '8',
                      icon: Icons.local_shipping,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _StatCard(
                      title: 'Pending',
                      value: '3',
                      icon: Icons.pending_actions,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _StatCard(
                      title: "Today's Earnings",
                      value: '₹480',
                      icon: Icons.currency_rupee,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today's Route",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '4 of 8 stops',
                    style: TextStyle(color: AppColors.grey, fontSize: 13),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              ...stops.map(_buildStopCard),

              const SizedBox(height: 8),

              _buildTipCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.supplierPrimary, AppColors.supplierDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.local_shipping,
              color: AppColors.supplierDark,
              size: 28,
            ),
          ),

          const SizedBox(width: 14),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ravi Kumar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Bengaluru North Route',
                  style: TextStyle(color: Colors.white, fontSize: 12.5),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SupplierLogin()),
              );
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildStopCard(_RouteStop stop) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
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
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: stop.isCurrent ? AppColors.supplierPrimary : AppColors.supplierLight,
            ),
            child: Text(
              '${stop.number}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: stop.isCurrent ? Colors.white : AppColors.supplierDark,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stop.customer,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  stop.address,
                  style: const TextStyle(color: AppColors.grey, fontSize: 12.5),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.near_me_outlined,
                      size: 14,
                      color: AppColors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      stop.distance,
                      style: const TextStyle(
                        color: AppColors.grey,
                        fontSize: 12.5,
                      ),
                    ),
                    const SizedBox(width: 10),
                    _statusChip(stop.status),
                  ],
                ),
                if (stop.isCurrent) ...[
                  const SizedBox(height: 12),
                  CustomButton(
                    label: 'Navigate',
                    isOutlined: true,
                    onPressed: () {},
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.supplierLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline, color: AppColors.supplierPrimary),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery Tip',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Group nearby stops together to finish your route faster and save fuel.',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    Color color;

    if (status == 'Delivered') {
      color = AppColors.success;
    } else if (status == 'In Route') {
      color = AppColors.supplierPrimary;
    } else {
      color = const Color(0xFFF59E0B);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
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
          Icon(icon, size: 20, color: AppColors.supplierPrimary),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.supplierDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: 11,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteStop {
  final int number;
  final String customer;
  final String address;
  final String distance;
  final String status;
  final bool isCurrent;

  const _RouteStop({
    required this.number,
    required this.customer,
    required this.address,
    required this.distance,
    required this.status,
    this.isCurrent = false,
  });
}
