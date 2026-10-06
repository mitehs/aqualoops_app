import 'package:flutter/material.dart';

import 'package:aqualoops_app/utils/app_colors.dart';

class BottomNavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const BottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

/// Reusable bottom navigation bar shared by the customer, admin and
/// supplier dashboards.
class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;
  final List<BottomNavItem> items;
  final Color? selectedColor;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> navItems = [];
    for (int i = 0; i < items.length; i++) {
      BottomNavItem item = items[i];
      navItems.add(
        BottomNavigationBarItem(
          icon: Icon(item.icon),
          activeIcon: Icon(item.activeIcon),
          label: item.label,
        ),
      );
    }

    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: selectedColor ?? AppColors.primary,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      onTap: onTap,
      items: navItems,
    );
  }
}
