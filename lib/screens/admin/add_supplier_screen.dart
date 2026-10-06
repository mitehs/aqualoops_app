import 'package:flutter/material.dart';

import 'package:aqualoops_app/models/supplier.dart';
import 'package:aqualoops_app/utils/app_colors.dart';
import 'package:aqualoops_app/widgets/custom_button.dart';
import 'package:aqualoops_app/widgets/custom_textfield.dart';

class AddSupplierScreen extends StatefulWidget {
  const AddSupplierScreen({super.key});

  @override
  State<AddSupplierScreen> createState() => _AddSupplierScreenState();
}

class _AddSupplierScreenState extends State<AddSupplierScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final routeController = TextEditingController();
  final passwordController = TextEditingController();

  String vehicleType = 'Bike';
  bool isSaving = false;

  static const List<String> vehicleTypes = ['Bike', 'Scooter', 'Van', 'Truck'];

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    routeController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    setState(() => isSaving = true);
    // Simulated save - UI only, no database / API.
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    // Hand the new supplier back so it appears in the list immediately.
    Navigator.pop(
      context,
      Supplier(
        name: nameController.text.trim(),
        route: routeController.text.trim(),
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        vehicle: vehicleType,
        earnings: 0,
      ),
    );
  }

  String? _required(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Build the choices of the vehicle dropdown first.
    List<DropdownMenuItem<String>> vehicleItems = [];
    for (int i = 0; i < vehicleTypes.length; i++) {
      String type = vehicleTypes[i];
      vehicleItems.add(DropdownMenuItem(value: type, child: Text(type)));
    }

    return Scaffold(
      backgroundColor: AppColors.adminBackground,
      appBar: AppBar(
        title: const Text('Add Supplier'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.adminPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Avatar placeholder
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 42,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person_add_alt_1_outlined,
                        size: 42,
                        color: AppColors.adminPrimary,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppColors.adminPrimary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: nameController,
                label: 'Full Name',
                prefixIcon: Icons.person_outline,
                validator: (value) => _required(value, 'Name is required'),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: phoneController,
                      label: 'Phone',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        final error = _required(value, 'Required');
                        if (error != null) return error;
                        if (value!.trim().length < 10) return 'Too short';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextField(
                      controller: emailController,
                      label: 'Email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        final error = _required(value, 'Required');
                        if (error != null) return error;
                        if (!value!.contains('@')) return 'Invalid email';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: routeController,
                label: 'Delivery Route / Area',
                prefixIcon: Icons.route_outlined,
                hint: 'e.g. Bengaluru North Route',
                validator: (value) => _required(value, 'Route is required'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: vehicleType,
                decoration: const InputDecoration(
                  labelText: 'Vehicle Type',
                  prefixIcon: Icon(Icons.directions_bike_outlined),
                  border: OutlineInputBorder(),
                ),
                items: vehicleItems,
                onChanged: (value) {
                  if (value != null) setState(() => vehicleType = value);
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: passwordController,
                label: 'Temporary Password',
                prefixIcon: Icons.lock_outline,
                obscureText: true,
                hint: 'Min 6 characters',
                validator: (value) {
                  final error = _required(value, 'Required');
                  if (error != null) return error;
                  if (value!.trim().length < 6) return 'Min 6 characters';
                  return null;
                },
              ),
              const SizedBox(height: 26),
              CustomButton(
                label: 'ADD SUPPLIER',
                color: AppColors.adminPrimary,
                isLoading: isSaving,
                onPressed: save,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
