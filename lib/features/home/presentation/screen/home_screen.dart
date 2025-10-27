import 'package:easy_book/features/home/presentation/screen/widget/body_home_screen.dart';
import 'package:easy_book/features/home/presentation/screen/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(), body: BodyHomeScreen());
  }
}
