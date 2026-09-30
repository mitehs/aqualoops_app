import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  int selectedAddress = 0;

  final List<Map<String, String>> addresses = [
    {'title': 'Home', 'address': 'RK University, Rajkot, Gujarat'},
    {'title': 'Work', 'address': 'Rajkot, Gujarat, India'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delivery Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: addresses.length,

                itemBuilder: (context, index) {
                  final address = addresses[index];

                  final selected = selectedAddress == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAddress = index;
                      });
                    },

                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),

                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),

                        border: Border.all(
                          color: selected
                              ? AppColors.primary
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Icon(
                            address['title'] == 'Home'
                                ? Icons.home
                                : Icons.work,
                            color: AppColors.primary,
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  address['title']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  address['address']!,
                                  style: const TextStyle(
                                    color: AppColors.grey,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Icon(
                            selected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: selected
                                ? AppColors.primary
                                : AppColors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Add Address
            SizedBox(
              width: double.infinity,
              height: 52,

              child: OutlinedButton.icon(
                onPressed: () {
                  showAddAddressDialog(context);
                },

                icon: const Icon(Icons.add),

                label: const Text('ADD NEW ADDRESS'),

                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,

                  side: const BorderSide(color: AppColors.primary),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Select Address
            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                child: const Text(
                  'SELECT ADDRESS',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAddAddressDialog(BuildContext context) {
    final addressController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Address'),

          content: TextField(
            controller: addressController,

            maxLines: 3,

            decoration: const InputDecoration(
              hintText: 'Enter your address',
              border: OutlineInputBorder(),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Address added')));
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
