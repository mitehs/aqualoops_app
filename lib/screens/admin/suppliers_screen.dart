import 'package:flutter/material.dart';

import 'package:aqualoops_app/models/supplier.dart';
import 'package:aqualoops_app/utils/app_colors.dart';
import 'package:aqualoops_app/widgets/status_chip.dart';

import 'package:aqualoops_app/screens/admin/add_supplier_screen.dart';

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({super.key});

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  final searchController = TextEditingController();
  String searchText = '';
  String filter = 'All';

  final List<Supplier> suppliers = [
    Supplier(
      name: 'Ramesh Verma',
      route: 'Route A · Vijay Nagar',
      phone: '+91 98200 11223',
      email: 'ramesh@aqualoops.in',
      vehicle: 'Bike',
      earnings: 12400,
    ),
    Supplier(
      name: 'Sunita Rao',
      route: 'Route B · Palasia',
      phone: '+91 98933 44556',
      email: 'sunita@aqualoops.in',
      vehicle: 'Scooter',
      earnings: 9800,
    ),
    Supplier(
      name: 'Imran Khan',
      route: 'Route C · Rau',
      phone: '+91 99775 66112',
      email: 'imran@aqualoops.in',
      vehicle: 'Van',
      earnings: 8200,
    ),
    Supplier(
      name: 'Priya Nair',
      route: 'Route D · Bhawarkua',
      phone: '+91 97551 22889',
      email: 'priya@aqualoops.in',
      vehicle: 'Bike',
      earnings: 7600,
    ),
    Supplier(
      name: 'Deepak Joshi',
      route: 'Route E · Mhow Naka',
      phone: '+91 96912 34501',
      email: 'deepak@aqualoops.in',
      vehicle: 'Scooter',
      earnings: 4900,
      available: false,
    ),
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  int countFor(String value) {
    if (value == 'Active') {
      int count = 0;
      for (Supplier supplier in suppliers) {
        if (supplier.available) {
          count = count + 1;
        }
      }
      return count;
    }
    if (value == 'Inactive') {
      int count = 0;
      for (Supplier supplier in suppliers) {
        if (!supplier.available) {
          count = count + 1;
        }
      }
      return count;
    }
    return suppliers.length;
  }

  Future<void> addSupplier() async {
    Supplier? newSupplier = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddSupplierScreen()),
    );
    if (newSupplier == null || !mounted) {
      return;
    }
    setState(() => suppliers.insert(0, newSupplier));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${newSupplier.name} added to your team')),
    );
  }

  void openDetails(Supplier supplier) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            // Build the rows of the sheet first, one by one.
            List<Widget> sheetChildren = [];

            // Grabber
            sheetChildren.add(
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            );
            sheetChildren.add(const SizedBox(height: 18));

            sheetChildren.add(
              Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: AppColors.adminPrimary.withValues(
                      alpha: 0.12,
                    ),
                    child: Text(
                      supplier.name.isNotEmpty
                          ? supplier.name[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        color: AppColors.adminPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          supplier.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          supplier.route,
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  StatusChip(label: supplier.available ? 'Active' : 'Inactive'),
                ],
              ),
            );
            sheetChildren.add(const SizedBox(height: 18));

            sheetChildren.add(infoRow(Icons.phone_outlined, supplier.phone));
            if (supplier.email.isNotEmpty) {
              sheetChildren.add(infoRow(Icons.email_outlined, supplier.email));
            }
            if (supplier.vehicle.isNotEmpty) {
              sheetChildren.add(
                infoRow(
                  Icons.directions_bike_outlined,
                  '${supplier.vehicle} · ${supplier.earnings > 0 ? '₹${supplier.earnings.toStringAsFixed(0)} earned' : 'No earnings yet'}',
                ),
              );
            } else if (supplier.earnings > 0) {
              sheetChildren.add(
                infoRow(
                  Icons.currency_rupee,
                  '₹${supplier.earnings.toStringAsFixed(0)} earned',
                ),
              );
            }

            sheetChildren.add(const SizedBox(height: 6));

            sheetChildren.add(
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: supplier.available,
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.adminPrimary,
                title: const Text(
                  'Available for deliveries',
                  style: TextStyle(fontSize: 14),
                ),
                onChanged: (value) {
                  setSheetState(() => supplier.available = value);
                  setState(() {});
                },
              ),
            );
            sheetChildren.add(const SizedBox(height: 10));

            sheetChildren.add(
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.adminPrimary,
                        side: const BorderSide(color: AppColors.adminPrimary),
                        minimumSize: const Size(0, 48),
                      ),
                      icon: const Icon(Icons.call, size: 18),
                      label: const Text('Call'),
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Calling ${supplier.name}…')),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.adminPrimary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 48),
                      ),
                      icon: const Icon(Icons.chat_bubble_outline, size: 18),
                      label: const Text('Message'),
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Message sent to ${supplier.name}'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );

            return Padding(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 26),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: sheetChildren,
              ),
            );
          },
        );
      },
    );
  }

  Widget infoRow(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.adminPrimary),
          const SizedBox(width: 10),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // The suppliers that match the filter and the search text.
    List<Supplier> list = [];
    String query = searchText.toLowerCase();
    for (Supplier supplier in suppliers) {
      bool matchesFilter =
          filter == 'All' ||
          (filter == 'Active' && supplier.available) ||
          (filter == 'Inactive' && !supplier.available);
      bool matchesSearch =
          query.isEmpty ||
          supplier.name.toLowerCase().contains(query) ||
          supplier.route.toLowerCase().contains(query) ||
          supplier.phone.contains(query);
      if (matchesFilter && matchesSearch) {
        list.add(supplier);
      }
    }

    // Build the filter chips first.
    List<String> filterValues = ['All', 'Active', 'Inactive'];
    List<Widget> filterChips = [];
    for (int i = 0; i < filterValues.length; i++) {
      String value = filterValues[i];
      filterChips.add(
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            label: Text('$value  ${countFor(value)}'),
            selected: filter == value,
            selectedColor: AppColors.adminPrimary,
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: filter == value ? Colors.white : AppColors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            onSelected: (_) => setState(() => filter = value),
          ),
        ),
      );
    }

    // The little X button of the search field.
    Widget? clearSuffix;
    if (searchText.isNotEmpty) {
      clearSuffix = IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          searchController.clear();
          setState(() => searchText = '');
        },
      );
    }

    // Either the empty message or the list of suppliers.
    Widget body;
    if (list.isEmpty) {
      body = const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_search_outlined, size: 54, color: AppColors.grey),
            SizedBox(height: 12),
            Text(
              'No suppliers found',
              style: TextStyle(color: AppColors.grey, fontSize: 15),
            ),
            SizedBox(height: 4),
            Text(
              'Try a different search or filter',
              style: TextStyle(color: AppColors.grey, fontSize: 12),
            ),
          ],
        ),
      );
    } else {
      body = ListView.builder(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 96),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final supplier = list[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 6,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              leading: CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.adminPrimary.withValues(alpha: 0.12),
                child: Text(
                  supplier.name.isNotEmpty
                      ? supplier.name[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    color: AppColors.adminPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                supplier.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                '${supplier.route}\n₹${supplier.earnings.toStringAsFixed(0)} earned',
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
              isThreeLine: true,
              trailing: StatusChip(
                label: supplier.available ? 'Active' : 'Inactive',
              ),
              onTap: () => openDetails(supplier),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: AppColors.adminBackground,
      appBar: AppBar(
        title: const Text('Suppliers'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.adminPrimary,
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'admin-suppliers-add',
        backgroundColor: AppColors.adminPrimary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Add Supplier'),
        onPressed: addSupplier,
      ),
      body: Column(
        children: [
          // Search
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 4, 18, 0),
            child: TextField(
              controller: searchController,
              onChanged: (value) => setState(() => searchText = value),
              decoration: InputDecoration(
                hintText: 'Search name, route or phone...',
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                suffixIcon: clearSuffix,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Filters
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
            child: Row(children: filterChips),
          ),
          Expanded(child: body),
        ],
      ),
    );
  }
}
