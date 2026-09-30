import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import 'supplier_dashboard.dart';
import 'supplier_register.dart';

class SupplierLogin extends StatefulWidget {
  const SupplierLogin({super.key});

  @override
  State<SupplierLogin> createState() => _SupplierLoginState();
}

class _SupplierLoginState extends State<SupplierLogin> {
  final emailController = TextEditingController(
    text: AppConstants.demoSupplierEmail,
  );

  final passwordController = TextEditingController(
    text: AppConstants.demoSupplierPassword,
  );

  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (emailController.text.trim().isEmpty) {
      _showMessage('Please enter your email');
      return;
    }

    if (passwordController.text.trim().isEmpty) {
      _showMessage('Please enter your password');
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SupplierDashboard()),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplier Login'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),

            // Branded header
            const Center(
              child: CircleAvatar(
                radius: 46,
                backgroundColor: AppColors.supplierPrimary,
                child: Icon(
                  Icons.local_shipping,
                  color: Colors.white,
                  size: 44,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Center(
              child: Text(
                'AquaLoop Supplier Partner',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 8),

            const Center(
              child: Text(
                'Sign in to start your delivery route',
                style: TextStyle(color: AppColors.grey),
              ),
            ),

            const SizedBox(height: 35),

            CustomTextField(
              controller: emailController,
              label: 'Email',
              hint: 'supplier@aqualoops.in',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 20),

            CustomTextField(
              controller: passwordController,
              label: 'Password',
              prefixIcon: Icons.lock_outline,
              obscureText: hidePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  hidePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
              ),
            ),

            const SizedBox(height: 25),

            CustomButton(
              label: 'LOGIN',
              color: AppColors.supplierPrimary,
              onPressed: _login,
            ),

            const SizedBox(height: 10),

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SupplierRegister(),
                    ),
                  );
                },
                child: const Text(
                  'New supplier? Create Account',
                  style: TextStyle(color: AppColors.supplierDark),
                ),
              ),
            ),

            const SizedBox(height: 5),

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('← Back to Customer Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
