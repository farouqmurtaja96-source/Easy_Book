import 'package:flutter/material.dart';

class CustomImageSplash extends StatelessWidget {
  const CustomImageSplash({
    super.key,
    required this.startAnimation,
    required this.image,
    required this.milliseconds,
    this.top,
    this.left,
    this.right,
    this.bottom,
    required this.height,
  });

  final bool startAnimation;
  final String image;
  final int milliseconds;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: startAnimation ? top : -300,
      left: startAnimation ? left : -300,
      right: startAnimation ? right : -300,
      bottom: startAnimation ? bottom : -300,
      duration: Duration(milliseconds: milliseconds),
      curve: Curves.easeInOut,
      child: SizedBox(height: height, child: Image.asset(image)),
    );
  }
}
