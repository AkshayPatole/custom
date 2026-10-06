import 'package:flutter/material.dart';

import '../const/app_colors.dart';
import '../const/app_strings.dart';

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
      ),
      body: const Center(
        child: Text(AppStrings.welcome,style: TextStyle(fontSize: 24,color: AppColors.orangeColor),),
      ),
    );
  }
}