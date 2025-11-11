import 'package:easy_book/features/library/data/model/library_model.dart';
import 'package:easy_book/features/library/presentation/screen/widget/custom_image_library.dart';
import 'package:flutter/material.dart';

class MyBookGridView extends StatelessWidget {
  const MyBookGridView({super.key, required this.books});
  final List<LibraryModel> books;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 20,
        childAspectRatio: 0.69,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageLibrary(book: books[index]),
            const SizedBox(height: 8),
            Text(
              books[index].name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3),
            Text(
              books[index].author,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
    );
  }
}
