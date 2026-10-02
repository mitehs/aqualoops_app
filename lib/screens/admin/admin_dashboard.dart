import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/bottom_navbar.dart';
import 'admin_login_screen.dart';
import 'customers_screen.dart';
import 'products_screen.dart';
import 'add_product_screen.dart';
import 'reports_screen.dart';
import 'settings_screen.dart';
import 'suppliers_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int selectedIndex = 0;

  late final List<Widget> pages = [
    _DashboardHome(onOpenTab: openTab),
    const CustomersScreen(),
    const ProductsScreen(),
    const SuppliersScreen(),
    const ReportsScreen(),
  ];

  void openTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.adminBackground,
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: selectedIndex,
        selectedColor: AppColors.adminPrimary,
        onTap: openTab,
        items: const [
          BottomNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Dashboard',
          ),
          BottomNavItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'Customers',
          ),
          BottomNavItem(
            icon: Icons.inventory_2_outlined,
            activeIcon: Icons.inventory_2,
            label: 'Products',
          ),
          BottomNavItem(
            icon: Icons.local_shipping_outlined,
            activeIcon: Icons.local_shipping,
            label: 'Suppliers',
          ),
          BottomNavItem(
            icon: Icons.insert_chart_outlined,
            activeIcon: Icons.insert_chart,
            label: 'Reports',
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
  final ValueChanged<int> onOpenTab;

  final List<_RecentOrder> recentOrders = const [
    _RecentOrder(
      id: '#AQ-1048',
      customer: 'Rahul Sharma',
      amount: 480,
      status: 'Delivered',
    ),
    _RecentOrder(
      id: '#AQ-1047',
      customer: 'Priya Verma',
      amount: 240,
      status: 'Shipped',
    ),
    _RecentOrder(
      id: '#AQ-1046',
      customer: 'Amit Singh',
      amount: 120,
      status: 'Pending',
    ),
    _RecentOrder(
      id: '#AQ-1045',
      customer: 'Sneha Iyer',
      amount: 960,
      status: 'Delivered',
    ),
  ];

  const _DashboardHome({required this.onOpenTab});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================================
          // ADMIN HEADER
          // =====================================
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(18, topPadding, 18, 22),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.adminPrimary, AppColors.adminSecondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(9),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.admin_panel_settings,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Admin Panel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          AppConstants.demoAdminEmail,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const AdminLoginScreen()),
                    );
                  },
                  icon: const Icon(Icons.logout, color: Colors.white),
                  tooltip: 'Logout',
                ),
              ],
            ),
          ),

          const SizedBox(height: 3),

          // =====================================
          // STATS
          // =====================================
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 1.7,
            children: const [
              _StatCard(
                title: 'Total Sales',
                value: '₹48,500',
                icon: Icons.currency_rupee,
                color: AppColors.success,
              ),
              _StatCard(
                title: 'Orders',
                value: '128',
                icon: Icons.shopping_bag_outlined,
                color: Colors.orange,
              ),
              _StatCard(
                title: 'Customers',
                value: '64',
                icon: Icons.people_outline,
                color: AppColors.primary,
              ),
              _StatCard(
                title: 'Products',
                value: '12',
                icon: Icons.inventory_2_outlined,
                color: AppColors.adminPrimary,
              ),
            ],
          ),

          const SizedBox(height: 22),

          // =====================================
          // QUICK ACTIONS
          // =====================================
          const Text(
            'Quick Actions',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _QuickAction(
                icon: Icons.add_box_outlined,
                label: 'Add Product',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddProductScreen()),
                  );
                },
              ),
              _QuickAction(
                icon: Icons.settings_outlined,
                label: 'Settings',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
              ),
              _QuickAction(
                icon: Icons.local_shipping_outlined,
                label: 'Suppliers',
                onTap: () => onOpenTab(3),
              ),
              _QuickAction(
                icon: Icons.insert_chart_outlined,
                label: 'Reports',
                onTap: () => onOpenTab(4),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // =====================================
          // RECENT ORDERS
          // =====================================
          const Text(
            'Recent Orders',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: _cardDecoration(),
            child: Column(
              children: [
                for (int i = 0; i < recentOrders.length; i++) ...[
                  if (i > 0) const Divider(height: 16),
                  _RecentOrderRow(order: recentOrders[i]),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.adminPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: const TextStyle(color: AppColors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
          decoration: _cardDecoration(),
          child: Column(
            children: [
              Icon(icon, color: AppColors.adminPrimary, size: 24),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentOrderRow extends StatelessWidget {
  final _RecentOrder order;

  const _RecentOrderRow({required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.id,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                order.customer,
                style: const TextStyle(color: AppColors.grey, fontSize: 12),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${order.amount.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.adminPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: order.statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  order.status,
                  style: TextStyle(
                    color: order.statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentOrder {
  final String id;
  final String customer;
  final double amount;
  final String status;

  const _RecentOrder({
    required this.id,
    required this.customer,
    required this.amount,
    required this.status,
  });

  Color get statusColor {
    if (status == 'Delivered') return AppColors.success;
    if (status == 'Shipped') return Colors.blue;
    return Colors.orange;
  }
}

BoxDecoration _cardDecoration() {
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
