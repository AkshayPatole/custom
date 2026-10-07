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
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              AppStrings.welcome,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.orangeColor,
              ),
            ),
            const SizedBox(height: 30),
            
            const CustomButton(),
            
            const SizedBox(height: 16),
            
            CustomButton(
              text: 'Get Started',
              icon: Icons.arrow_forward,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Button Pressed!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}