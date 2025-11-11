import 'package:easy_book/core/utils/app_routers.dart';
import 'package:easy_book/features/home/presentation/screen/widget/category_list_view.dart';
import 'package:easy_book/features/home/presentation/screen/widget/custom_text_feild.dart';
import 'package:easy_book/features/home/presentation/screen/widget/newset_list.dart';
import 'package:easy_book/features/home/presentation/screen/widget/trending_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: CustomTextFeild(
              onSubmitted: (value) {

                final String query = value;
                GoRouter.of(context).push(AppRouters.ksearch, extra: query);
              },
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 15)),
          SliverToBoxAdapter(child: CategoryListView(),),
          SliverToBoxAdapter(child: const SizedBox(height: 15,),),
          SliverToBoxAdapter(child: TrendingList(),),
          SliverToBoxAdapter(child: const SizedBox(height: 15,),),
          SliverToBoxAdapter(child: NewsetList(),)
        ],
      ),
    );
  }
}
