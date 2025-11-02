import 'package:easy_book/features/details/presentation/screen/widget/custom_body_details_screen.dart';
import 'package:easy_book/features/details/presentation/screen/widget/custom_bottom_sheet.dart';
import 'package:easy_book/features/details/presentation/screen/widget/top_app_bar_details_screen.dart';
import 'package:easy_book/core/utils/color_constans.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.07),
          TopAppBarDetailsScreen(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          CustomBodyDetailsScreen(),
        ],
      ),
      bottomSheet: CustomBottomSheet(),
    );
  }
}
