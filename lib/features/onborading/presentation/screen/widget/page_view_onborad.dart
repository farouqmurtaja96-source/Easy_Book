import 'package:easy_book/features/onborading/data/onborad_model.dart';
import 'package:flutter/material.dart';

class PageViewOnborad extends StatelessWidget {
  const PageViewOnborad({
    super.key,
    required this.pageController,
    required this.onPageChanged,
    required this.currentIndex,
  });

  final PageController pageController;
  final Function(int) onPageChanged;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: OnBoradModel.onBoradList.length,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              child: Image.asset(
                OnBoradModel.onBoradList[index].image,
                fit: currentIndex == 2 ? BoxFit.fitWidth : BoxFit.fitHeight,
              ),
            ),
            SizedBox(height: currentIndex == 0 ? 40 : 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                OnBoradModel.onBoradList[index].title,

                style: const TextStyle(
                  fontSize: 22,

                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                OnBoradModel.onBoradList[index].description,
                style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }
}
