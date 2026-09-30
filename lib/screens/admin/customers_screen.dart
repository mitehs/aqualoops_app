import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final TextEditingController searchController = TextEditingController();

  String searchText = '';

  final List<_DemoCustomer> customers = const [
    _DemoCustomer(
      name: 'Rahul Sharma',
      email: 'rahul.sharma@gmail.com',
      phone: '+91 98200 11223',
      address: '221, MG Road, Indore',
      orders: 18,
      totalSpent: 4260,
    ),
    _DemoCustomer(
      name: 'Priya Verma',
      email: 'priya.verma@gmail.com',
      phone: '+91 98933 44556',
      address: '12, Scheme No. 54, Indore',
      orders: 12,
      totalSpent: 2880,
    ),
    _DemoCustomer(
      name: 'Amit Singh',
      email: 'amit.singh@gmail.com',
      phone: '+91 99775 66112',
      address: '88, Palasia Main Road, Indore',
      orders: 9,
      totalSpent: 2160,
    ),
    _DemoCustomer(
      name: 'Sneha Iyer',
      email: 'sneha.iyer@gmail.com',
      phone: '+91 97551 22889',
      address: '5, Vijay Nagar, Indore',
      orders: 22,
      totalSpent: 6140,
    ),
    _DemoCustomer(
      name: 'Vikas Patil',
      email: 'vikas.patil@gmail.com',
      phone: '+91 96912 34501',
      address: '41, Rau Colony, Indore',
      orders: 5,
      totalSpent: 1080,
    ),
    _DemoCustomer(
      name: 'Anjali Deshmukh',
      email: 'anjali.deshmukh@gmail.com',
      phone: '+91 95221 77340',
      address: '7, Bhawarkua Main Road, Indore',
      orders: 14,
      totalSpent: 3520,
    ),
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<_DemoCustomer> get filteredCustomers {
    final query = searchText.trim().toLowerCase();
    if (query.isEmpty) return customers;

    return customers
        .where(
          (customer) =>
              customer.name.toLowerCase().contains(query) ||
              customer.email.toLowerCase().contains(query) ||
              customer.phone.contains(query),
        )
        .toList();
  }

  void showCustomerDetails(_DemoCustomer customer) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: AppColors.adminPrimary.withValues(
                        alpha: 0.12,
                      ),
                      child: Text(
                        customer.initials,
                        style: const TextStyle(
                          color: AppColors.adminPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customer.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            customer.email,
                            style: const TextStyle(
                              color: AppColors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                _detailRow(Icons.phone_outlined, customer.phone),
                const SizedBox(height: 10),
                _detailRow(
                  Icons.location_on_outlined,
                  customer.address,
                ),
                const SizedBox(height: 10),
                _detailRow(
                  Icons.receipt_long_outlined,
                  '${customer.orders} total orders',
                ),
                const SizedBox(height: 10),
                _detailRow(
                  Icons.currency_rupee,
                  '₹${customer.totalSpent.toStringAsFixed(0)} total spent',
                ),
                const SizedBox(height: 20),
                CustomButton(
                  label: 'BLOCK CUSTOMER',
                  isOutlined: true,
                  color: AppColors.danger,
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${customer.name} blocked (demo)'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detailRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.adminPrimary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final results = filteredCustomers;
    final summary = searchText.trim().isEmpty
        ? '64 customers'
        : '${results.length} customers found';

    return Scaffold(
      backgroundColor: AppColors.adminBackground,
      appBar: AppBar(
        title: const Text('Customers'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.adminPrimary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search customers...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.adminPrimary,
                ),
                suffixIcon: searchText.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                            searchText = '';
                          });
                        },
                      ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 4),
            child: Text(
              summary,
              style: const TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        'No customers found',
                        style: TextStyle(color: AppColors.grey),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final customer = results[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: _cardDecoration(),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          onTap: () => showCustomerDetails(customer),
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.adminPrimary.withValues(
                              alpha: 0.12,
                            ),
                            child: Text(
                              customer.initials,
                              style: const TextStyle(
                                color: AppColors.adminPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            customer.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 2),
                              Text(
                                customer.email,
                                style: const TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                customer.phone,
                                style: const TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.adminPrimary.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${customer.orders} orders',
                                  style: const TextStyle(
                                    color: AppColors.adminPrimary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.chevron_right,
                                color: AppColors.grey,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _DemoCustomer {
  final String name;
  final String email;
  final String phone;
  final String address;
  final int orders;
  final double totalSpent;

  const _DemoCustomer({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.orders,
    required this.totalSpent,
  });

  String get initials => name
      .split(' ')
      .map((word) => word[0])
      .take(2)
      .join()
      .toUpperCase();
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
