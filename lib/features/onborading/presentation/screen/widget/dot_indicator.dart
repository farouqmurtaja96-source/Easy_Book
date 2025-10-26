import 'package:easy_book/features/onborading/data/onborad_model.dart';
import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  const DotsIndicator({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return currentIndex == 2
        ? Container(
            height: 60,
            width: 190,
            decoration: BoxDecoration(
              color: Color(0xffDE7773),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'Get Started Now',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              OnBoradModel.onBoradList.length,
              (index) => AnimatedContainer(
                duration: Duration(milliseconds: 500),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 8,
                width: currentIndex == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? Colors.deepPurple
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          );
  }
}
