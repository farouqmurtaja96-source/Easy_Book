import 'package:easy_book/features/home/presentation/screen/home_screen.dart';
import 'package:easy_book/features/home/presentation/screen/widget/custom_app_bar.dart';
import 'package:easy_book/features/home/presentation/screen/widget/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    // Placeholder screens for other tabs
    const Center(child: Text('Search Screen')),
    const Center(child: Text('Favorites Screen')),
    const Center(child: Text('Profile Screen')),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 ? const CustomAppBar() : null,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
