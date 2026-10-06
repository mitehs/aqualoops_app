import 'package:flutter/material.dart';

import 'package:aqualoops_app/utils/app_colors.dart';
import 'package:aqualoops_app/utils/constants.dart';
import 'package:aqualoops_app/widgets/custom_button.dart';
import 'package:aqualoops_app/widgets/custom_textfield.dart';

import 'package:aqualoops_app/screens/admin/admin_dashboard.dart';
import 'package:aqualoops_app/screens/auth/login_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final emailController = TextEditingController(
    text: AppConstants.demoAdminEmail,
  );
  final passwordController = TextEditingController(
    text: AppConstants.demoAdminPassword,
  );

  bool hidePassword = true;
  bool isLoading = false;
  String? errorText;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorText = 'Please enter email and password';
      });
      return;
    }
    setState(() {
      isLoading = true;
      errorText = null;
    });
    // Simulated check - UI only, no database / API.
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    // Simulated login - any non-empty email & password opens the dashboard.
    // Remove every earlier screen so the back button never returns to Login.
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AdminDashboard()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.adminBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              // Logo
              Container(
                height: 90,
                width: 90,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.adminPrimary,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.admin_panel_settings,
                  size: 46,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Admin Panel',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.adminPrimary,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Sign in to manage AquaLoop',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.grey),
              ),

              const SizedBox(height: 36),

              CustomTextField(
                controller: emailController,
                label: 'Admin Email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 18),

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

              if (errorText != null) const SizedBox(height: 14),

              if (errorText != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: AppColors.danger,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          errorText!,
                          style: const TextStyle(
                            color: AppColors.danger,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 26),

              CustomButton(
                label: 'LOGIN',
                color: AppColors.adminPrimary,
                isLoading: isLoading,
                onPressed: login,
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text('← Back to Customer Login'),
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Demo: admin@aqualoops.in / admin123',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: AppColors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
