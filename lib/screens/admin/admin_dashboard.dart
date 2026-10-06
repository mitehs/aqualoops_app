import 'package:flutter/material.dart';
import 'package:aqualoops_app/utils/app_colors.dart';
import 'package:aqualoops_app/utils/constants.dart';
import 'package:aqualoops_app/widgets/bottom_navbar.dart';
import 'package:aqualoops_app/screens/admin/admin_login_screen.dart';
import 'package:aqualoops_app/screens/admin/customers_screen.dart';
import 'package:aqualoops_app/screens/admin/products_screen.dart';
import 'package:aqualoops_app/screens/admin/add_product_screen.dart';
import 'package:aqualoops_app/screens/admin/reports_screen.dart';
import 'package:aqualoops_app/screens/admin/settings_screen.dart';
import 'package:aqualoops_app/screens/admin/suppliers_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int selectedIndex = 0;

  // Demo data for the Recent Orders section.
  final List<Map<String, dynamic>> recentOrders = [
    {
      'id': '#AQ-1048',
      'customer': 'Rahul Sharma',
      'amount': 480,
      'status': 'Delivered',
    },
    {
      'id': '#AQ-1047',
      'customer': 'Priya Verma',
      'amount': 240,
      'status': 'Shipped',
    },
    {
      'id': '#AQ-1046',
      'customer': 'Amit Singh',
      'amount': 120,
      'status': 'Pending',
    },
    {
      'id': '#AQ-1045',
      'customer': 'Sneha Iyer',
      'amount': 960,
      'status': 'Delivered',
    },
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
        children: [
          buildHome(),
          const CustomersScreen(),
          const ProductsScreen(),
          const SuppliersScreen(),
          const ReportsScreen(),
        ],
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

  // =====================================================
  // DASHBOARD HOME TAB
  // =====================================================

  Widget buildHome() {
    final topPadding = MediaQuery.of(context).padding.top;

    // One row per recent order, with a divider in between.
    List<Widget> orderRows = [];
    for (int i = 0; i < recentOrders.length; i++) {
      if (i > 0) {
        orderRows.add(const Divider(height: 16));
      }
      orderRows.add(recentOrderRow(recentOrders[i]));
    }

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
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(9)),
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
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminLoginScreen(),
                      ),
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
            children: [
              statCard(
                'Total Sales',
                '₹48,500',
                Icons.currency_rupee,
                AppColors.success,
              ),
              statCard(
                'Orders',
                '128',
                Icons.shopping_bag_outlined,
                Colors.orange,
              ),
              statCard(
                'Customers',
                '64',
                Icons.people_outline,
                AppColors.primary,
              ),
              statCard(
                'Products',
                '12',
                Icons.inventory_2_outlined,
                AppColors.adminPrimary,
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
              quickAction(Icons.add_box_outlined, 'Add Product', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddProductScreen(),
                  ),
                );
              }),
              quickAction(Icons.settings_outlined, 'Settings', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              }),
              quickAction(Icons.local_shipping_outlined, 'Suppliers', () {
                openTab(3);
              }),
              quickAction(Icons.insert_chart_outlined, 'Reports', () {
                openTab(4);
              }),
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
            decoration: cardDecoration(),
            child: Column(children: orderRows),
          ),
        ],
      ),
    );
  }

  Widget statCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: cardDecoration(),
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

  Widget quickAction(IconData icon, String label, void Function() onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
          decoration: cardDecoration(),
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

  Widget recentOrderRow(Map<String, dynamic> order) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${order['id']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${order['customer']}',
                style: const TextStyle(color: AppColors.grey, fontSize: 12),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${order['amount']}',
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
                  color: statusColor(
                    '${order['status']}',
                  ).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${order['status']}',
                  style: TextStyle(
                    color: statusColor('${order['status']}'),
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

  Color statusColor(String status) {
    if (status == 'Delivered') {
      return AppColors.success;
    }
    if (status == 'Shipped') {
      return Colors.blue;
    }
    return Colors.orange;
  }

  BoxDecoration cardDecoration() {
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
}
