import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_book/features/library/data/model/library_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomImageLibrary extends StatelessWidget {
  const CustomImageLibrary({super.key, required this.book});
  final LibraryModel book;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CachedNetworkImage(
        height: 190,
        width: 145,
        fit: BoxFit.fill,
        imageUrl: book.image,

        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: double.infinity,
            height: 150, // حجم الصندوق المؤقت
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12), // لو عندك زوايا مدورة
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
