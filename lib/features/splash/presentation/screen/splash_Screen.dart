import 'package:easy_book/features/splash/presentation/screen/widget/custom_image_splash.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff171B36),
      body: Stack(
        children: [
          CustomImageSplash(
            top: 0,
            left: 0,
            height: 380,
            image: 'assets/image/Ellipse 1.png',
          ),
          CustomImageSplash(
            bottom: 100,
            right: 0,
            height: 560,
            image: 'assets/image/Ellipse 2.png',
          ),
          CustomImageSplash(
            bottom: 0,
            left: 0,
            height: 450,
            image: 'assets/image/Ellipse 3.png',
          ),
          CustomImageSplash(
            top: 125,
            left: 125,
            right: 125,
            bottom: 125,
            height: 60,
            image: 'assets/image/logo.png',
          ),
        ],
      ),
    );
  }
}
