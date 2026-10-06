import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'set_new_password_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [
            const SizedBox(height: 40),

            const Icon(
              Icons.mark_email_read_outlined,
              size: 80,
              color: AppColors.primary,
            ),

            const SizedBox(height: 25),

            const Text(
              'Enter OTP',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              'Enter the 4-digit OTP sent to '
              'your registered mobile number.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.grey, height: 1.5),
            ),

            const SizedBox(height: 35),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: List.generate(4, (index) {
                return Container(
                  width: 55,
                  height: 60,

                  margin: const EdgeInsets.symmetric(horizontal: 5),

                  child: TextField(
                    controller: controllers[index],

                    textAlign: TextAlign.center,

                    keyboardType: TextInputType.number,

                    maxLength: 1,

                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),

                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                    ),

                    onChanged: (value) {
                      if (value.isNotEmpty && index < 3) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                );
              }),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('OTP verified successfully')),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SetNewPasswordScreen(),
                    ),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                child: const Text(
                  'VERIFY OTP',

                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextButton(onPressed: () {}, child: const Text('Resend OTP')),
          ],
        ),
      ),
    );
  }
}
