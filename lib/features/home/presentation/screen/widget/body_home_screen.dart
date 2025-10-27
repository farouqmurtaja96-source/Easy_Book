import 'package:easy_book/features/home/presentation/screen/widget/category_list_view.dart';
import 'package:easy_book/features/home/presentation/screen/widget/custom_text_feild.dart';
import 'package:flutter/material.dart';

class BodyHomeScreen extends StatelessWidget {
  const BodyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        CustomTextFeild(),
        const SizedBox(height: 15),
        CategoryListView(),
      ],
    );
  }
}
