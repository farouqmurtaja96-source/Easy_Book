import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_book/features/library/presentation/screen/widget/book_caroudel.dart';
import 'package:easy_book/features/library/presentation/screen/widget/top_library_body.dart';
import 'package:easy_book/utils/color_constans.dart';
import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
        ),
      ],
    );
  }
}
