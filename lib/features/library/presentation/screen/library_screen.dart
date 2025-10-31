import 'package:easy_book/features/library/presentation/screen/widget/my_book_grid_view.dart';
import 'package:easy_book/features/library/presentation/screen/widget/recently_read_body.dart';
import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RecentlyReadBody(),
        Expanded(child: MyBooksBody()),
      ],
    );
  }
}

class MyBooksBody extends StatelessWidget {
  const MyBooksBody({super.key});

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
            MyBookGridView(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
