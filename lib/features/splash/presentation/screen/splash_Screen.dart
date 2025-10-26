import 'package:easy_book/features/onborading/data/repository/onboarding_repo.dart';
import 'package:easy_book/features/splash/presentation/screen/widget/custom_image_splash.dart';
import 'package:easy_book/utils/app_routers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.repo});
  final OnboardingRepo repo;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController logoController;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;

  bool startAnimation = false;

  @override
  void initState() {
    super.initState();

    logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    scaleAnimation = Tween<double>(begin: 0.4, end: 1).animate(
      CurvedAnimation(parent: logoController, curve: Curves.easeOutBack),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: logoController, curve: Curves.easeOutBack),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      setState(() {
        startAnimation = true;
      });

      Future.delayed(const Duration(milliseconds: 600), () {
        if (!mounted) return;
        logoController.forward();
      });
    });
    bool done = widget.repo.isDone();
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (!mounted) return;
      if (done) {
        context.go(AppRouters.kHome);
      } else {
        GoRouter.of(context).push(AppRouters.kOnborad);
      }
    });
  }

  @override
  void dispose() {
    logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff171B36),
      body: Stack(
        children: [
          CustomImageSplash(
            startAnimation: startAnimation,
            image: 'assets/image/Ellipse 1.png',
            milliseconds: 800,
            top: 0,
            left: 0,
            height: 380,
          ),
          CustomImageSplash(
            startAnimation: startAnimation,
            image: 'assets/image/Ellipse 2.png',
            milliseconds: 900,
            bottom: 100,
            right: 0,
            height: 560,
          ),
          CustomImageSplash(
            startAnimation: startAnimation,
            image: 'assets/image/Ellipse 3.png',
            milliseconds: 900,
            bottom: 0,
            left: 0,
            height: 450,
          ),

          Center(
            child: FadeTransition(
              opacity: fadeAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: SizedBox(
                  height: 120,
                  child: Image.asset('assets/image/logo.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
