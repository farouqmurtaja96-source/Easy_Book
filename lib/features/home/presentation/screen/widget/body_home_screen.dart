import 'package:easy_book/features/home/presentation/screen/widget/category_list_view.dart';
import 'package:easy_book/features/home/presentation/screen/widget/custom_text_feild.dart';
import 'package:easy_book/features/home/presentation/screen/widget/newset_list.dart';
import 'package:easy_book/features/home/presentation/screen/widget/trending_list.dart';
import 'package:flutter/material.dart';

class BodyHomeScreen extends StatelessWidget {
  const BodyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: const CustomTextFeild()),
          SliverToBoxAdapter(child: const SizedBox(height: 15)),
          SliverToBoxAdapter(child: const CategoryListView()),
          SliverToBoxAdapter(child: const SizedBox(height: 15)),
          SliverToBoxAdapter(child: TrendingList()),
          SliverToBoxAdapter(child: const SizedBox(height: 15)),
          SliverToBoxAdapter(child: NewsetList()),
        ],
      ),
    );
  }
}
//  Column(
//               children: [
                
//                 const CustomTextFeild(),
//                 const SizedBox(height: 15),
//                 const CategoryListView(),
//                 const SizedBox(height: 25),
//                 const TrendingList(),
//                 const SizedBox(height: 20),
//                 Expanded(child: const NewsetList()),
//               ],
//             ),