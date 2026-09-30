import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'otp_screen.dart';

class ForgotPasswordScreen
    extends StatelessWidget {

  ForgotPasswordScreen({super.key});

  final TextEditingController emailController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Forgot Password'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 40),

            const Center(
              child: Icon(
                Icons.lock_reset,
                size: 80,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Forgot Password?',
              style: TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Enter your email or mobile number. '
              'We will send you an OTP to reset '
              'your password.',
              style: TextStyle(
                color: AppColors.grey,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller:
                  emailController,

              decoration:
                  const InputDecoration(
                labelText:
                    'Email / Mobile Number',

                prefixIcon:
                    Icon(Icons.email_outlined),

                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton(
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const OtpScreen(),
                    ),
                  );

                },

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.primary,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      15,
                    ),
                  ),
                ),

                child: const Text(
                  'SEND OTP',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}