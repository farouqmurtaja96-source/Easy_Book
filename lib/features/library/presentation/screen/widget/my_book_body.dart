import 'package:easy_book/features/library/data/model/library_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_book/features/library/presentation/screen/widget/my_book_grid_view.dart';

class MyBooksBody extends StatelessWidget {
  const MyBooksBody({super.key, required this.books});
  final List<LibraryModel> books;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'My Books',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            MyBookGridView(books: books),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
