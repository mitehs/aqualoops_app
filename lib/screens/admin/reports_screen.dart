import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final List<_ReportPeriod> periods = const [
    _ReportPeriod(
      label: 'Today',
      revenue: 4200,
      orders: 18,
      newCustomers: 3,
      bars: [0.4, 0.55, 0.35, 0.6, 0.5, 0.7, 0.45],
    ),
    _ReportPeriod(
      label: 'This Week',
      revenue: 28400,
      orders: 96,
      newCustomers: 14,
      bars: [0.55, 0.7, 0.45, 0.8, 0.65, 1.0, 0.6],
    ),
    _ReportPeriod(
      label: 'This Month',
      revenue: 48500,
      orders: 128,
      newCustomers: 26,
      bars: [0.6, 0.5, 0.75, 0.65, 0.9, 0.85, 1.0],
    ),
    _ReportPeriod(
      label: 'Year',
      revenue: 512000,
      orders: 1450,
      newCustomers: 310,
      bars: [0.3, 0.45, 0.5, 0.6, 0.7, 0.85, 1.0],
    ),
  ];

  final List<_TopProduct> topProducts = const [
    _TopProduct(name: '20L Mineral Water', units: 320, share: 0.92),
    _TopProduct(name: '1L Water Bottle', units: 245, share: 0.74),
    _TopProduct(name: '500ml Water Bottle', units: 180, share: 0.55),
    _TopProduct(name: '20L Premium Water', units: 96, share: 0.31),
  ];

  final List<String> dayLabels = const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  String selectedPeriod = 'This Week';

  _ReportPeriod get currentPeriod =>
      periods.firstWhere((period) => period.label == selectedPeriod);

  @override
  Widget build(BuildContext context) {
    final period = currentPeriod;

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
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final item in periods)
                ChoiceChip(
                  label: Text(item.label),
                  selected: selectedPeriod == item.label,
                  onSelected: (value) {
                    setState(() {
                      selectedPeriod = item.label;
                    });
                  },
                  showCheckmark: false,
                  backgroundColor: Colors.white,
                  selectedColor: AppColors.adminPrimary,
                  side: const BorderSide(color: AppColors.adminPrimary),
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: selectedPeriod == item.label
                        ? Colors.white
                        : AppColors.adminPrimary,
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          // =====================================
          // SUMMARY CARDS
          // =====================================
          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  label: 'Revenue',
                  value: '₹${period.revenue.toStringAsFixed(0)}',
                  icon: Icons.currency_rupee,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryCard(
                  label: 'Orders',
                  value: '${period.orders}',
                  icon: Icons.shopping_bag_outlined,
                  color: AppColors.adminPrimary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryCard(
                  label: 'New Customers',
                  value: '${period.newCustomers}',
                  icon: Icons.people_outline,
                  color: Colors.orange,
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
            decoration: _cardDecoration(),
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
                    children: [
                      for (int i = 0; i < dayLabels.length; i++)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 22,
                                  height: (period.bars[i] * 120)
                                      .roundToDouble(),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.adminPrimary,
                                        AppColors.primary,
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  dayLabels[i],
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
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
            decoration: _cardDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Top Products',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                for (int i = 0; i < topProducts.length; i++) ...[
                  if (i > 0) const SizedBox(height: 14),
                  _TopProductRow(product: topProducts[i]),
                ],
              ],
            ),
          ),

          const SizedBox(height: 22),

          CustomButton(
            label: 'Export Report',
            icon: Icons.download_outlined,
            color: AppColors.adminPrimary,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$selectedPeriod report exported (demo)')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: _cardDecoration(),
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
}

class _TopProductRow extends StatelessWidget {
  final _TopProduct product;

  const _TopProductRow({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                product.name,
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
              '${product.units} units',
              style: const TextStyle(color: AppColors.grey, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: LinearProgressIndicator(
            value: product.share,
            minHeight: 6,
            backgroundColor: AppColors.lightGrey,
            color: AppColors.adminPrimary,
          ),
        ),
      ],
    );
  }
}

class _ReportPeriod {
  final String label;
  final double revenue;
  final int orders;
  final int newCustomers;
  final List<double> bars;

  const _ReportPeriod({
    required this.label,
    required this.revenue,
    required this.orders,
    required this.newCustomers,
    required this.bars,
  });
}

class _TopProduct {
  final String name;
  final int units;
  final double share;

  const _TopProduct({
    required this.name,
    required this.units,
    required this.share,
  });
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
