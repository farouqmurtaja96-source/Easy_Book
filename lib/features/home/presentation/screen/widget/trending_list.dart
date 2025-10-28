import 'package:easy_book/features/home/presentation/screen/widget/trending_list_view.dart';
import 'package:flutter/material.dart';

class TrendingList extends StatelessWidget {
  const TrendingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Trending',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Text(
              'View All',
              style: TextStyle(
                color: Color.fromARGB(255, 214, 175, 34),
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const TrendingListView(),
      ],
    );
  }
}
