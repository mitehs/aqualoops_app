import 'package:flutter/material.dart';
import 'package:aqualoops_app/screens/auth/splash_screen.dart';
import 'package:aqualoops_app/utils/app_colors.dart';

void main() {
  runApp(const AquaLoopApp());
}

class AquaLoopApp extends StatelessWidget {
  const AquaLoopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AquaLoop',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}
