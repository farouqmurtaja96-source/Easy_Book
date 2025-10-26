import 'package:easy_book/features/onborading/data/repository/onboarding_repo.dart';
import 'package:easy_book/features/onborading/presentation/screen/widget/dot_indicator.dart';
import 'package:easy_book/features/onborading/presentation/screen/widget/page_view_onborad.dart';
import 'package:easy_book/utils/app_routers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboradScreen extends StatefulWidget {
  const OnboradScreen({super.key, required this.repo});
  final OnboardingRepo repo;

  @override
  State<OnboradScreen> createState() => _OnboradScreenState();
}

class _OnboradScreenState extends State<OnboradScreen> {
  final PageController pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: currentIndex == 2
                  ? SizedBox.shrink()
                  : Row(
                      children: [
                        Icon(Icons.arrow_back, color: Colors.grey),
                        Spacer(),
                        GestureDetector(
                          onTap: () async {
                            await widget.repo.setDone();
                            GoRouter.of(context).push(AppRouters.kHome);
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 0),
            Expanded(
              child: PageViewOnborad(
                pageController: pageController,
                currentIndex: currentIndex,
                onPageChanged: (i) {
                  setState(() {
                    currentIndex = i;
                  });
                },
              ),
            ),
            SizedBox(height: currentIndex == 2 ? 20 : 0),
            DotsIndicator(currentIndex: currentIndex, repo: widget.repo),
            SizedBox(height: currentIndex == 2 ? 40 : 60),
          ],
        ),
      ),
    );
  }
}
