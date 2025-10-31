import 'package:flutter/material.dart';
import 'package:easy_book/features/library/presentation/screen/widget/book_caroudel.dart';
import 'package:easy_book/features/library/presentation/screen/widget/top_library_body.dart';
import 'package:easy_book/utils/color_constans.dart';

class RecentlyReadBody extends StatelessWidget {
  const RecentlyReadBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      color: AppColor.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          TopLibraryBody(),
          const SizedBox(height: 20),

          SizedBox(height: 250, child: BookCarousel()),
        ],
      ),
    );
  }
}
