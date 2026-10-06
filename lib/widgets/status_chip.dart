import 'package:flutter/material.dart';

import 'package:aqualoops_app/utils/app_colors.dart';

/// Small pill that shows a coloured order / account status.
class StatusChip extends StatelessWidget {
  final String label;

  const StatusChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final color = colorFor(label);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static Color colorFor(String value) {
    switch (value.toLowerCase()) {
      case 'delivered':
      case 'active':
      case 'paid':
        return AppColors.success;
      case 'out for delivery':
      case 'packed':
      case 'pending':
        return const Color(0xFFF59E0B);
      case 'inactive':
      case 'cancelled':
        return AppColors.danger;
      default:
        return AppColors.primary;
    }
  }
}
