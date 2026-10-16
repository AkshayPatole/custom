import 'dart:async';
import 'package:flutter/material.dart';
import '../const/app_colors.dart';
import '../const/app_strings.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              _buildLogo(),
              const SizedBox(height: 24),
              _buildTitle(),
              const Spacer(),
              _buildLoader(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

 

  //  Logo Container
  Widget _buildLogo() {
    return Container(
      width: 90,
      height: 90,
      decoration: const BoxDecoration(
        color: AppColors.orangeColor,
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(
          Icons.flutter_dash_rounded,
          size: 50,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  //  Title & Subtitle
  Widget _buildTitle() {
    return const Column(
      children: [
        Text(
          AppStrings.splashTitle,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.orangeColor,
          ),
        ),
        SizedBox(height: 8),
        Text(
          AppStrings.splashTagline,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor,
          ),
        ),
      ],
    );
  }

  //  Loader Indicator
  Widget _buildLoader() {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.orangeColor),
      ),
    );
  }
}
