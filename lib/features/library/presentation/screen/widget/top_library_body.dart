import 'package:easy_book/features/library/data/model/library_model.dart';
import 'package:flutter/material.dart';

class TopLibraryBody extends StatelessWidget {
  const TopLibraryBody({super.key, required this.books});
  final List<LibraryModel> books;
  @override
  Widget build(BuildContext context) {
    final totalBooks = books.length;
    final totalHours = books.fold<double>(0, (sum, b) => sum + b.readingHours);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: Image.asset('assets/image/pngwing.com.png'),
            ),

            const SizedBox(width: 15),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  totalBooks.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Total read',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(width: 20),
            SizedBox(
              height: 40,
              child: VerticalDivider(color: Colors.white, thickness: 1),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      totalHours.round().toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      ' hr',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  'Total Reading',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
