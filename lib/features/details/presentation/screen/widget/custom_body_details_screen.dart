import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_book/core/model/book_model/book_model.dart';
import 'package:flutter/material.dart';

class CustomBodyDetailsScreen extends StatelessWidget {
  const CustomBodyDetailsScreen({super.key, required this.books});
  final BookModel books;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  books.title ?? '',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(137, 20, 20, 20),
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Text(
                  (books.authors != null && books.authors!.isNotEmpty)
                      ? books.authors![0].name ?? ''
                      : 'Unknown author',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey.shade400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 50),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              height: 190,
              width: 140,
              imageUrl:
                  books.formats!.imageJpeg ??
                  'https://picsum.photos/250?image=9',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
