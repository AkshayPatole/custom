import 'package:flutter/material.dart';
import '../const/app_colors.dart';
import '../const/app_strings.dart';
import '../const/custom_button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              // 1. Header Section
              _buildHeader(),
              const SizedBox(height: 16),
              
              // 2. Forgot Password Link
              _buildForgotPassword(),
              const SizedBox(height: 30),
              // 3. Custom Button
              CustomButton(
                text: AppStrings.signIn,
                onPressed: () {
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildHeader() {
    return const Column(
      children: [
        Text(
          AppStrings.loginTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.orangeColor,
          ),
        ),
        SizedBox(height: 16),
        Text(
          AppStrings.loginSubtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            height: 1.3,
          ),
        ),
      ],
    );
  }


  //  Method: Forgot Password Link
  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {},
        child: const Text(
          AppStrings.forgotPassword,
          style: TextStyle(
            color: AppColors.orangeColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // Private Method: Social Login Section
  // Widget _buildSocialLogin() {
  //   return Column(
  //     children: [
  //       const Text(
  //         AppStrings.orContinueWith,
  //         style: TextStyle(
  //           color: AppColors.orangeColor,
  //           fontWeight: FontWeight.bold,
  //           fontSize: 14,
  //         ),
  //       ),
  //       const SizedBox(height: 20),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           _buildSocialIconButton(isCustomText: 'G'),
  //           const SizedBox(width: 12),
  //           _buildSocialIconButton(icon: Icons.facebook),
  //           const SizedBox(width: 12),
  //           _buildSocialIconButton(icon: Icons.apple),
  //         ],
  //       ),
  //     ],
  //   );
  // }

}