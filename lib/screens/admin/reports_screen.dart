import 'package:flutter/material.dart';
import 'package:aqualoops_app/utils/app_colors.dart';
import 'package:aqualoops_app/widgets/custom_button.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final List<Map<String, dynamic>> periods = [
    {
      'label': 'Today',
      'revenue': 4200,
      'orders': 18,
      'newCustomers': 3,
      'bars': [0.4, 0.55, 0.35, 0.6, 0.5, 0.7, 0.45],
    },
    {
      'label': 'This Week',
      'revenue': 28400,
      'orders': 96,
      'newCustomers': 14,
      'bars': [0.55, 0.7, 0.45, 0.8, 0.65, 1.0, 0.6],
    },
    {
      'label': 'This Month',
      'revenue': 48500,
      'orders': 128,
      'newCustomers': 26,
      'bars': [0.6, 0.5, 0.75, 0.65, 0.9, 0.85, 1.0],
    },
    {
      'label': 'Year',
      'revenue': 512000,
      'orders': 1450,
      'newCustomers': 310,
      'bars': [0.3, 0.45, 0.5, 0.6, 0.7, 0.85, 1.0],
    },
  ];

  final List<Map<String, dynamic>> topProducts = [
    {'name': '20L Mineral Water', 'units': 320, 'share': 0.92},
    {'name': '1L Water Bottle', 'units': 245, 'share': 0.74},
    {'name': '500ml Water Bottle', 'units': 180, 'share': 0.55},
    {'name': '20L Premium Water', 'units': 96, 'share': 0.31},
  ];

  final List<String> dayLabels = const [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  String selectedPeriod = 'This Week';

  @override
  Widget build(BuildContext context) {
    // The data of the period that is currently selected.
    Map<String, dynamic> period = periods[0];
    for (int i = 0; i < periods.length; i++) {
      if (periods[i]['label'] == selectedPeriod) {
        period = periods[i];
        break;
      }
    }
    List<double> bars = period['bars'];

    // The chips of the period selector.
    List<Widget> periodChips = [];
    for (int i = 0; i < periods.length; i++) {
      Map<String, dynamic> item = periods[i];
      periodChips.add(
        ChoiceChip(
          label: Text('${item['label']}'),
          selected: selectedPeriod == item['label'],
          onSelected: (value) {
            setState(() {
              selectedPeriod = '${item['label']}';
            });
          },
          showCheckmark: false,
          backgroundColor: Colors.white,
          selectedColor: AppColors.adminPrimary,
          side: const BorderSide(color: AppColors.adminPrimary),
          labelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selectedPeriod == item['label']
                ? Colors.white
                : AppColors.adminPrimary,
          ),
        ),
      );
    }

    // The bars of the chart.
    List<Widget> barColumns = [];
    for (int i = 0; i < dayLabels.length; i++) {
      barColumns.add(
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 22,
                  height: (bars[i] * 120).roundToDouble(),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.adminPrimary, AppColors.primary],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  dayLabels[i],
                  style: const TextStyle(fontSize: 11, color: AppColors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // The children of the "Top Products" card.
    List<Widget> productCardChildren = [];
    productCardChildren.add(
      const Text(
        'Top Products',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
    productCardChildren.add(const SizedBox(height: 14));
    for (int i = 0; i < topProducts.length; i++) {
      if (i > 0) {
        productCardChildren.add(const SizedBox(height: 14));
      }
      productCardChildren.add(topProductRow(topProducts[i]));
    }

    return Scaffold(
      backgroundColor: AppColors.adminBackground,
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.adminPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
        children: [
          // =====================================
          // PERIOD SELECTOR
          // =====================================
          Wrap(spacing: 8, runSpacing: 8, children: periodChips),
          const SizedBox(height: 16),
          // =====================================
          // SUMMARY CARDS
          // =====================================
          Row(
            children: [
              Expanded(
                child: summaryCard(
                  'Revenue',
                  '₹${period['revenue']}',
                  Icons.currency_rupee,
                  AppColors.success,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: summaryCard(
                  'Orders',
                  '${period['orders']}',
                  Icons.shopping_bag_outlined,
                  AppColors.adminPrimary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: summaryCard(
                  'New Customers',
                  '${period['newCustomers']}',
                  Icons.people_outline,
                  Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // =====================================
          // BAR CHART (Row + Column, no package)
          // =====================================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
            decoration: cardDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Orders per Day',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Weekly sales trend (Mon - Sun)',
                  style: TextStyle(color: AppColors.grey, fontSize: 12),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 170,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: barColumns,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // =====================================
          // TOP PRODUCTS
          // =====================================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: cardDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: productCardChildren,
            ),
          ),
          const SizedBox(height: 22),
          CustomButton(
            label: 'Export Report',
            icon: Icons.download_outlined,
            color: AppColors.adminPrimary,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$selectedPeriod report exported (demo)'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // One summary card of the top row.
  Widget summaryCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.adminPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.grey, fontSize: 11),
          ),
        ],
      ),
    );
  }

  // One row of the "Top Products" card.
  Widget topProductRow(Map<String, dynamic> product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '${product['name']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '${product['units']} units',
              style: const TextStyle(color: AppColors.grey, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: LinearProgressIndicator(
            value: product['share'],
            minHeight: 6,
            backgroundColor: AppColors.lightGrey,
            color: AppColors.adminPrimary,
          ),
        ),
      ],
    );
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
