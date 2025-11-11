import 'package:easy_book/features/library/data/model/library_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_book/features/library/presentation/screen/widget/book_caroudel.dart';
import 'package:easy_book/features/library/presentation/screen/widget/top_library_body.dart';
import 'package:easy_book/core/utils/color_constans.dart';

class RecentlyReadBody extends StatelessWidget {
  const RecentlyReadBody({super.key, required this.books});
  final List<LibraryModel> books;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      color: AppColor.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          TopLibraryBody(books: books),
          const SizedBox(height: 20),

          SizedBox(height: 250, child: BookCarousel(books: books)),
        ],
      ),
    );
  }
}
