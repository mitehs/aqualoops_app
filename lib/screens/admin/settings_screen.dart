import 'package:flutter/material.dart';
import 'package:aqualoops_app/utils/app_colors.dart';
import 'package:aqualoops_app/utils/constants.dart';
import 'package:aqualoops_app/screens/admin/admin_login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;

  void showStoreInformation() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Store Information'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('AquaLoop Water Depot'),
              SizedBox(height: 8),
              Text(
                '12, Scheme No. 78, Vijay Nagar,\nIndore, MP 452010',
                style: TextStyle(color: AppColors.grey),
              ),
              SizedBox(height: 8),
              Text(
                'Support: ${AppConstants.supportPhone}',
                style: TextStyle(color: AppColors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void showDeliveryCharges() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Delivery Charges'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '₹${AppConstants.deliveryCharge.toStringAsFixed(0)} per order',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.adminPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Free delivery above ₹${AppConstants.freeDeliveryAbove.toStringAsFixed(0)}',
                style: const TextStyle(color: AppColors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void showPaymentMethods() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Payment Methods'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('• Cash on Delivery'),
              SizedBox(height: 6),
              Text('• UPI / QR Code'),
              SizedBox(height: 6),
              Text('• Credit & Debit Cards'),
              SizedBox(height: 6),
              Text('• Wallets'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void confirmLogout() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Logout?'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminLoginScreen(),
                  ),
                );
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: AppColors.danger),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: AppColors.grey,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.adminBackground,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.adminPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          // =====================================
          // PROFILE
          // =====================================
          Container(
            padding: const EdgeInsets.all(18),
            decoration: _cardDecoration(),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.adminPrimary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.admin_panel_settings,
                    color: AppColors.adminPrimary,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 14),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Admin',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      AppConstants.demoAdminEmail,
                      style: TextStyle(color: AppColors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          sectionTitle('PREFERENCES'),
          Container(
            decoration: _cardDecoration(),
            child: Column(
              children: [
                SwitchListTile(
                  value: notificationsEnabled,
                  activeThumbColor: Colors.white,
                  activeTrackColor: AppColors.adminPrimary,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  secondary: const Icon(
                    Icons.notifications_outlined,
                    color: AppColors.adminPrimary,
                  ),
                  title: const Text('Notifications'),
                  subtitle: const Text(
                    'Order and delivery alerts',
                    style: TextStyle(color: AppColors.grey, fontSize: 12),
                  ),
                  onChanged: (value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  value: darkModeEnabled,
                  activeThumbColor: Colors.white,
                  activeTrackColor: AppColors.adminPrimary,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  secondary: const Icon(
                    Icons.dark_mode_outlined,
                    color: AppColors.adminPrimary,
                  ),
                  title: const Text('Dark Mode'),
                  subtitle: const Text(
                    'Visual only in this demo',
                    style: TextStyle(color: AppColors.grey, fontSize: 12),
                  ),
                  onChanged: (value) {
                    setState(() {
                      darkModeEnabled = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          sectionTitle('GENERAL'),
          Container(
            decoration: _cardDecoration(),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  leading: const Icon(
                    Icons.storefront_outlined,
                    color: AppColors.adminPrimary,
                  ),
                  title: const Text('Store Information'),
                  subtitle: const Text(
                    'Address and contact details',
                    style: TextStyle(color: AppColors.grey, fontSize: 12),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: AppColors.grey,
                  ),
                  onTap: showStoreInformation,
                ),
                const Divider(height: 1),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  leading: const Icon(
                    Icons.delivery_dining_outlined,
                    color: AppColors.adminPrimary,
                  ),
                  title: const Text('Delivery Charges'),
                  subtitle: const Text(
                    'Applies per order',
                    style: TextStyle(color: AppColors.grey, fontSize: 12),
                  ),
                  trailing: Text(
                    '₹${AppConstants.deliveryCharge.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.adminPrimary,
                    ),
                  ),
                  onTap: showDeliveryCharges,
                ),
                const Divider(height: 1),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  leading: const Icon(
                    Icons.payment_outlined,
                    color: AppColors.adminPrimary,
                  ),
                  title: const Text('Payment Methods'),
                  subtitle: const Text(
                    '4 methods enabled',
                    style: TextStyle(color: AppColors.grey, fontSize: 12),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: AppColors.grey,
                  ),
                  onTap: showPaymentMethods,
                ),
                const Divider(height: 1),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  leading: const Icon(
                    Icons.lock_outline,
                    color: AppColors.adminPrimary,
                  ),
                  title: const Text('Change Password'),
                  subtitle: const Text(
                    'Update your login password',
                    style: TextStyle(color: AppColors.grey, fontSize: 12),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: AppColors.grey,
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Password reset link sent (demo)'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          sectionTitle('ABOUT'),
          Container(
            decoration: _cardDecoration(),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  leading: const Icon(
                    Icons.info_outline,
                    color: AppColors.adminPrimary,
                  ),
                  title: const Text('App Version'),
                  trailing: Text(
                    AppConstants.appVersion,
                    style: const TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  leading: const Icon(Icons.logout, color: AppColors.danger),
                  title: const Text(
                    'Logout',
                    style: TextStyle(
                      color: AppColors.danger,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: confirmLogout,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
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
